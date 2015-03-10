module ROM
  module InfluxDB
    class Relation < ROM::Relation
      def insert(object)
        dataset << object
        self
      end
    end
  end
end
