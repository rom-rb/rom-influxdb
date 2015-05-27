require 'spec_helper'

require 'rom/lint/spec'

describe ROM::InfluxDB::Gateway do
  let(:gateway) { ROM::InfluxDB::Gateway }
  let(:uri) { 'influxdb://localhost' }

  it_behaves_like "a rom gateway" do
    let(:identifier) { :influxdb }
  end

  describe '.new' do
    context 'default values' do
      let(:connection) { gateway.new(uri).connection }

      it 'returns them' do
        expect(connection.database).to be_nil
        expect(connection.hosts).to include('localhost')
        expect(connection.port).to eql(8086)
        expect(connection.username).to eql('root')
        expect(connection.password).to eql('root')
      end
    end

    context 'overwritten values' do
      let(:uri) { 'influxdb://somewhere:9999/rom' }
      let(:opts) { { username: 'john', password: 'doe' } }
      let(:connection) { gateway.new(uri, opts).connection }

      it 'allows to set dbname in url' do
        expect(connection.database).to eql('rom')
      end

      it 'allows to set host' do
        expect(connection.hosts).to include('somewhere')
      end

      it 'allows to set port' do
        expect(connection.port).to eql(9999)
      end

      it 'allows to set username' do
        expect(connection.username).to eql('john')
      end

      it 'allows to set password' do
        expect(connection.password).to eql('doe')
      end
    end
  end
end
