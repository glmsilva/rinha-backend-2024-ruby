# frozen_string_literal: true
class ClientesController < Roda
  route do |r|
    r.on Integer do |id|
      r.is "extrato" do
        cliente = Cliente[id]

        if cliente.nil?
          response.status = 404
          return {}.to_json
        end

        transacoes = Transacao.ultimas_transacoes(id)

        Alba.serialize do
          attribute :saldo do
            SaldoSerializer.new(cliente).to_h
          end

          attribute :ultimas_transacoes do
            TransacaoSerializer.new(transacoes).to_h
          end
        end
      end

      r.post "transacoes" do
        cliente = Cliente[id]

        if cliente.nil?
          response.status = 404
          return {}.to_json
        end

        params = r.body.read
        puts params
        contract = TransacaoContract.new.call(JSON.parse(params))

        if contract.errors.any?
          response.status = 422
          return {erro: contract.errors.to_h}.to_json
        end

        begin
          Cliente.db.transaction do
            cliente.lock!
            Transacao.create do |c|
              c.cliente_id = id
              c.valor = contract["valor"]
              c.tipo = contract["tipo"]
              c.descricao = contract["descricao"]
              c.realizada_em = Time.now()
            end
  
            novo_saldo = if contract["tipo"] == 'c'
                            saldo = cliente.saldo + contract["valor"]
                        else
                            saldo = cliente.saldo - contract["valor"]
                        end
  
            cliente.update(saldo: novo_saldo)
          end  
        rescue
          response.status = 422
          return {erro: "xii..."}.to_json
        end

        
        {
          "limite": cliente.limite,
          "saldo": cliente.saldo
        }
        .to_json
      end
    end
  end
end
