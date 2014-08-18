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
              username: columns[1],
              date: columns[2],
              method: columns[3],
              path: URI.unescape(columns[4]),
              status_code: columns[5],
              bytes: columns[6]
            }
          end

          formatted_lines
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
    end
  end
end
