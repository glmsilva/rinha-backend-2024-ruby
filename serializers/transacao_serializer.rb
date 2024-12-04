class TransacaoSerializer
  include Alba::Resource

  attributes :valor, :tipo, :descricao, :realizada_em
end