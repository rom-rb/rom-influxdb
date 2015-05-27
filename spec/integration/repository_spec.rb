require 'spec_helper'

require 'virtus'

describe 'InfluxDB gateway' do
  subject(:rom) { setup.finalize }

  let(:setup) { ROM.setup(:influxdb, 'influxdb://localhost/db') }
  let(:gateway) { rom.gateways[:default] }

  before do
    setup.relation(:users) do
      def by_name(name)
        where("name = '#{name}'")
      end
    end

    setup.commands(:users) do
      define(:create)
    end

    user_model = Class.new do
      include Virtus.value_object

      values do
        attribute :name, String
      end
    end

    setup.mappers do
      define(:users) do
        model(user_model)

        attribute :name, from: 'name'
      end
    end

    rom.relations.users.insert('name' => 'Jane')
    rom.relations.users.insert('name'=> 'Joe')
  end

  describe 'env#relation' do
    it 'returns mapped object' do
      jane = rom.relation(:users).by_name('Jane').map_with(:users).one!

      expect(jane.name).to eql('Jane')
    end
  end

  describe 'gateway#dataset?' do
    it 'returns true if a collection exists' do
      expect(gateway.dataset?(:users)).to be(true)
    end

    it 'returns false if a does not collection exist' do
      expect(gateway.dataset?(:not_here)).to be(false)
    end
  end

  describe 'commands' do
    let(:commands) { rom.command(:users) }

    describe 'create' do
      it 'inserts a document into collection' do
        result = commands.create.call(name: 'ben')

        expect(result).to match_array([{ name: 'ben' }])
      end

      it 'ensure that record was created' do
        commands.create.call(name: 'ben')

        expect(rom.relation(:users).by_name('ben').one)
          .to include('name' => 'ben')
      end
    end
  end
end
