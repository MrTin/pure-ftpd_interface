module Kookie
  module PureFTPD

    class Interface < Sinatra::Base

      get '/' do
        log_lines = File.readlines('test/support_files/transfers.log').reverse[0, ENV['TAIL_LINES'].to_i].to_a
        @logs = LogParser.new(log_lines).parse

        haml :index
      end

      helpers do

        def bytes_to_human_size(bytes)
          if bytes <= 0
            return '-'
          end

          (bytes / (1024 * 1024)).round(2).to_s + ' MB'
        end
      end

      use Rack::Auth::Basic do |username, password|
        username == ENV['USERNAME'] && password == ENV['PASSWORD']
      end

      use Rack::Deflater
    end
  end
end
