module Kookie
  module PureFTPD

    class Interface < Sinatra::Base

      use Rack::Auth::Basic do |username, password|
        username == ENV['USERNAME'] && password == ENV['PASSWORD']
      end

      get '/' do
        log_lines = File.readlines('test/support_files/transfers.log').reverse[0, ENV['TAIL_LINES'].to_i].to_a
        @logs = LogParser.new(log_lines).parse

        haml :index
      end

      use Rack::Deflater
    end
  end
end
