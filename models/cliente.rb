# frozen_string_literal: true

require 'sequel'

class Cliente < Sequel::Model(:clientes)
  one_to_many :transacoes, class: "Transacao"
end    


