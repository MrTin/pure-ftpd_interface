module Kookie
  module PureFTPD

    class Interface < Sinatra::Base

      get '/' do
        log_lines = File.readlines(ENV['LOG_PATH']).reverse[0, ENV['TAIL_LINES'].to_i].to_a
        @logs = LogParser.new(log_lines).parse

        haml :index
      end

      post '/users/create' do
        begin
          User.create(params[:username], params[:password])
          flash[:success] = "An account with username <strong>#{params[:username]}</strong> has been created."
        rescue Sequel::UniqueConstraintViolation
          flash[:error] = "An account with the username <strong>#{params[:username]}</strong> already exists."
        end

        redirect '/'
      end

      get '/users/destroy/:username' do
        User.where(:User => params[:username]).destroy
        flash[:info] = "The account with username <strong>#{params[:username]}</strong> has been destroyed."

        redirect '/'
      end

      helpers do

        def strip_path_and_username_from(path, username)
          path.sub!(/#{ENV['REMOVE_PATH_PREFIX']}?\/#{username}\//i, '')
        end

        def suggest_password(length = 8)
          SecureRandom.hex(length)
        end

        def bytes_to_human_size(bytes)
          if bytes <= 0
            return '-'
          end

          (bytes / (1024 * 1024)).round(2).to_s + ' MB'
        end

        def minutes_in_words(timestamp)
          minutes = ((Time.now.to_i - timestamp) / 60).round

          return nil if minutes < 0

          case minutes
            when 0..4            then '< 5 minutes'
            when 5..14           then '< 15 minutes'
            when 15..29          then '< 30 minutes'
            when 30..59          then '> 30 minutes'
            when 60..119         then '> 1 hour'
            when 120..239        then '> 2 hours'
            when 240..479        then '> 4 hours'
            when 480..719        then '> 8 hours'
            when 720..1439       then '> 12 hours'
            when 1440..11519     then '> ' << pluralize((minutes/1440).floor, 'day')
            when 11520..43199    then '> ' << pluralize((minutes/11520).floor, 'week')
            when 43200..525599   then '> ' << pluralize((minutes/43200).floor, 'month')
            else                      '> ' << pluralize((minutes/525600).floor, 'year')
          end
        end

        def pluralize(amount, string_to_pluralize)
          if amount > 1
            "#{amount} #{string_to_pluralize}s"
          else
            "#{amount} #{string_to_pluralize}"
          end
        end
      end

      use Rack::Auth::Basic do |username, password|
        username == ENV['USERNAME'] && password == ENV['PASSWORD']
      end

      use Rack::Deflater

      register Sinatra::Flash
      enable :sessions
    end
  end
end
