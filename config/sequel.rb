require 'sequel'

DB = Sequel.connect(adapter: 'postgresql', host: 'db', port: '5432', user: 'admin', password: '123', database: 'rinha')

Sequel::Model.db = DB