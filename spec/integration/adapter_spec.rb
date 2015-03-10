require 'spec_helper'

describe 'ROM / InfluxDB / Setup' do
  before do
    ROM.setup(:influxdb)
  end

  let(:rom) { ROM.finalize.env }

  it 'works' do
    class Users < ROM::Relation[:influxdb]
    end

    users = rom.relations.users

    users.insert('name' => 'Oskar')

    expect(users.to_a).to include([{ 'name' => 'Oskar' }])
  end
end
