require 'spec_helper'

require 'rom/lint/spec'

describe ROM::InfluxDB::Repository do
  let(:repository) { ROM::InfluxDB::Repository }
  let(:uri) { nil }

  it_behaves_like "a rom repository" do
    let(:identifier) { :influxdb }
  end
end
