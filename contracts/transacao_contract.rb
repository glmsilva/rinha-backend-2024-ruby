class TransacaoContract < Dry::Validation::Contract
  json do
    required(:valor).value(:integer)
    required(:tipo).value(:string)
    required(:descricao).value(:string)
  end 

  rule(:tipo) do
    key.failure('ooops') unless ['c', 'd'].include?(values[:tipo])
  end

  rule(:descricao) do
    key.failure('muito grande =o') if values[:descricao].size > 10
  end
end