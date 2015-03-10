module ROM
  module InfluxDB
    class Dataset
      include Equalizer.new(:name, :connection)

      attr_reader :name, :connection

      def initialize(name, connection)
        @name = name.to_s
        @connection = connection
      end

      def each(&block)
        with_set { |set| set.each(&block) }
      end

      def insert(object)
        connection.write_point(name, object)
      end
      alias_method :<<, :insert

      private

      def with_set
        yield(connection.query("select * from #{name}"))
      end
    end
  end
end
