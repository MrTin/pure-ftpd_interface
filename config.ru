require 'rubygems'
require 'bundler'
require 'dotenv'

Bundler.require
Dotenv.load

require './kookie/pure_ftpd/interface'
run Kookie::PureFTPD::Interface
