require 'rom/commands'

module ROM
  module InfluxDB
    module Commands
      class Create < ROM::Commands::Create
        def collection
          relation.dataset
        end

        def execute(document)
          collection << document
          [document]
        end
      end
    end
  end
end
