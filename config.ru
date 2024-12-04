require 'roda'
require 'json'
require 'alba'
require 'dry-validation'
require_relative 'config/sequel'
require_relative 'models/cliente'
require_relative 'models/transacao'
require_relative 'serializers/saldo_serializer'
require_relative 'serializers/transacao_serializer'
require_relative 'contracts/transacao_contract'

require_relative 'rinha_backend_2024_ruby'

run RinhaBackend2024Ruby.freeze.app