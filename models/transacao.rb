# frozen_string_literal: true

require 'sequel'

class Transacao < Sequel::Model(:transacoes)
  many_to_one :cliente, class: "Cliente"

  dataset_module do
    def ultimas_transacoes(id)
      select(:valor, :tipo, :descricao, :realizada_em).
        where(cliente_id: id).
        order(Sequel.desc(:realizada_em)).
        limit(10)
    end
  end
end
