# encoding: utf-8

require 'bundler'
Bundler.setup

if RUBY_ENGINE == 'rbx'
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require 'rom-influxdb'

root = Pathname(__FILE__).dirname

Dir[root.join('shared/*.rb').to_s].each { |f| require f }

RSpec.configure do |config|
  config.before do
    @constants = Object.constants
    create_db
  end

  config.after do
    added_constants = Object.constants - @constants
    added_constants.each { |name| Object.send(:remove_const, name) }
    drop_db
  end

  def create_db
    ::InfluxDB::Client.new.create_database("db")
  end

  def drop_db
    ::InfluxDB::Client.new.delete_database("db")
  end
end
