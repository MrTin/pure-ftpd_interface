require 'rubygems'
require 'bundler'
require 'dotenv'
require 'digest'

Bundler.require
Dotenv.load

DB = Sequel.connect(ENV['CONNECTION_URL'])

require './kookie/pure_ftpd/interface'
require './kookie/pure_ftpd/log_parser'
require './kookie/pure_ftpd/models/user'
run Kookie::PureFTPD::Interface

enable :sessions
