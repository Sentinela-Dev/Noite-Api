require 'mongo'
require 'dotenv'

Dotenv.load

## DatabaseConfig
module MongoDatabase
  def self.database_connection
    database_name = 'noite_api'

    connection_string = ENV['MONGODB_CONNECTION_STRING']

    database_url = case ENV['RACK_ENV']
                   when 'production'
                     connection_string
                   when 'test'
                     "mongodb://root:example@127.0.0.1:27017/#{database_name}_test?serverSelectionTimeoutMS=2000&authSource=admin"
                   else
                     "mongodb://root:example@127.0.0.1:27017/#{database_name}_dev?serverSelectionTimeoutMS=2000&authSource=admin"
                   end

    client = Mongo::Client.new(database_url)
    @database_connection ||= client.database
  end
end
