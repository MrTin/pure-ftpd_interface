module Kookie
  module PureFTPD

    class Interface < Sinatra::Base

      get '/' do
        log_lines = File.readlines('test/support_files/transfers.log').reverse[0, ENV['TAIL_LINES'].to_i].to_a
        @logs = LogParser.new(log_lines).parse

        haml :index
      end

      use Rack::Deflater
    end
  end
end
