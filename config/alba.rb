require 'alba'

Alba.encoder = ->(object) { JSON.generate(object) }