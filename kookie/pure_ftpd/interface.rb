module Kookie
  module PureFTPD

    class Interface < Sinatra::Base

      disable :static

      set :erb, escape_html: true,
                layout_options: { views: 'views/layouts' }

      get '/' do

      end

      use Rack::Deflater
    end
  end
end
