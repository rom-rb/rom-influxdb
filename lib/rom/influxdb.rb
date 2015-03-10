require 'influxdb'

require 'rom'
require 'rom/influxdb/version'
require 'rom/influxdb/repository'

ROM.register_adapter(:influxdb, ROM::InfluxDB)
