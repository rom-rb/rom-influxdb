module ROM
  module InfluxDB
    class Relation < ROM::Relation
      forward :query, :where, :insert
    end
  end
end
