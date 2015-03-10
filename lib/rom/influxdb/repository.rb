require 'rom/influxdb/dataset'
require 'rom/influxdb/relation'

module ROM
  module InfluxDB
    class Repository < ROM::Repository
      attr_reader :sets

      def initialize
        @connection = ::InfluxDB::Client.new('db')
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
    end
  end
end
