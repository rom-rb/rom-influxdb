require 'rom/influxdb/dataset'
require 'rom/influxdb/relation'

module ROM
  module InfluxDB
    class Repository < ROM::Repository
      attr_reader :sets

      def initialize(uri, options = {})
        @connection = connect(uri, options)
        @sets = {}
      end

      def dataset(name)
        sets[name] = Dataset.new(name, connection)
      end

      def [](name)
        sets.fetch(name)
      end

      def dataset?(name)
        connection.get_database_list.include?(name)
      end

      private

      def connect(uri, options)
        uri = URI.parse(uri)
        host = uri.host
        port = uri.port
        dbname = uri.path[1..-1]
        params = { host: host, port: port }.merge(options)
        ::InfluxDB::Client.new(dbname, params)
      end
    end
  end
end
