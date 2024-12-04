class SaldoSerializer
  include Alba::Resource

  attribute :total do |resource|
    resource.saldo
  end

  attribute :data_extrato  do
    Time.now
  end

  attributes :limite
end