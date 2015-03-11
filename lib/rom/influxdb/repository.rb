require 'rom/influxdb/dataset'
require 'rom/influxdb/relation'

module ROM
  module InfluxDB
    class Repository < ROM::Repository
      attr_reader :sets

      # InfluxDB repository interface
      #
      # @overload connect(uri, options)
      #   Connects to database via uri passing options
      #
      #   @param [String,Symbol] uri connection URI
      #   @param [Hash] options connection options
      #
      # @example
      #   repository = ROM::InfluxDB::Repository.new('influxdb://localhost/rom',
      #     { username: 'foo', password: 'bar' })
      #
      # @api public
      def initialize(uri, options = {})
        @connection = connect(uri, options)
        @sets = {}
      end

      # Return dataset with the given name
      #
      # @param [String] name a dataset name
      #
      # @return [Dataset]
      #
      # @api public
      def dataset(name)
        sets[name] = Dataset.new(name, connection)
      end

      # Return dataset with the given name
      #
      # @param [String] name dataset name
      #
      # @return [Dataset]
      #
      # @api public
      def [](name)
        sets.fetch(name)
      end

      # Check if dataset exists
      #
      # @param [String] name dataset name
      #
      # @api public
      def dataset?(name)
        connection.get_database_list.include?(name)
      end

      private

      # Connect to database
      #
      # @return [Database::InfluxDB] a connection instance
      #
      # @api private
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
