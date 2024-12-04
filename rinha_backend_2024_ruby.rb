# frozen_string_literal: true

require_relative 'controllers/clientes_controller'
class RinhaBackend2024Ruby < Roda
  plugin :multi_run
  
  route do |r|
    r.root do
      "Hello, Roda"
    end

    r.on "clientes" do
      r.run ClientesController
    end
  end
end