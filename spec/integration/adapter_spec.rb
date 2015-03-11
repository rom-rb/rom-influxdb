require 'spec_helper'

describe 'ROM / InfluxDB / Setup' do
  before do
    ROM.setup(:influxdb, 'influxdb://localhost/db')
  end

  let(:rom) { ROM.finalize.env }

  it 'works' do
    class Users < ROM::Relation[:influxdb]
    end

    users = rom.relations.users

    users.insert('name' => 'Oskar')

    expect(users.to_a.size).to eq(1)
    expect(users.to_a[0]).to include('name' => 'Oskar')
  end
end
