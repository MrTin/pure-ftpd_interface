module Kookie
  module PureFTPD

    class LogParser

      def initialize(log_lines)
        @log_lines = log_lines
      end

      def parse
        @parsed_lines ||= parse_lines
      end

      protected

        def parse_lines
          formatted_lines = []
          @log_lines.each do |line|

            columns = find_columns(line)

            formatted_lines << {
              ip: columns[0],
              username: ensure_safe_encoding(columns[1]),
              date: parse_date(columns[2]),
              method: columns[3],
              path: URI.unescape(ensure_safe_encoding(columns[4])),
              status_code: columns[5].to_i,
              bytes: columns[6].to_i
            }
          end

          formatted_lines
        end

        def parse_date(date_string)
          Time.strptime(date_string, '%d/%b/%Y:%T %z')
        end

        def find_columns(line)
          /(.*) - (.*) \[(.*)\] "(.*) (.*)" (.*) (.*)/.match(line).captures

          # A log entry will look something like this
          # 62.57.246.102 - gyj [13/Aug/2014:12:09:22 -0000] \"PUT /home/ftp-accounts/gyj/miabelleza/MIA%20BELLEZA%20108.PDF\" 200 17233868

          # And this is how it's broken down using the pattern above
          # columns[0] = 62.57.246.102
          # columns[1] = gyj
          # columns[2] = 13/Aug/2014:12:09:22 -0000
          # columns[3] = PUT
          # columns[4] = /home/ftp-accounts/gyj/miabelleza/MIA%20BELLEZA%20108.PDF
          # columns[5] = 200
          # columns[6] = 17233868
        end

        def ensure_safe_encoding(text)
          text.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
        end
    end
  end
end
