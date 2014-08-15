require 'rubygems'
require 'bundler'
require 'dotenv'

Bundler.require
Dotenv.load

require './kookie/pure_ftpd/interface'
require './kookie/pure_ftpd/log_parser'
run Kookie::PureFTPD::Interface
