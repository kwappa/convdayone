require 'time'

module Convdayone
  class TextFiles
    def self.import(dir)
      filenames = Dir.glob(File.join(dir, '*.txt'))
      filenames.sort.each do |filename|
        data_file = DataFile.new(filename)
        data =  data_file.parse
        data.each do |d|
          puts "#{d[:date].strftime('%F %T')} : #{d[:text][0 .. 60].gsub(/[\r\n]/, '')}"
          Convdayone::CLI.create(d[:text], date: d[:date])
        end
      end
    end

    class DataFile
      def initialize(filename)
        @name = filename
        match = @name.match(/.+\/(?<year>\d{4})(?<month>\d{2}?)\.txt/)
        @year = match[:year].to_i
        @month = match[:month].to_i
        @mode = :start
        @date = nil
        @buffer = []
        @result = []
      end

      def parse
        lines = File.open(@name, "r:BOM|UTF-8") { |f| f.read }

        lines.each_line do |line|

          case @mode

          when :start
            if check_start_line(line)
              parse_md_date(line)
            end

          when :find_date
            match = line.match(/(?<m>\d+)\/(?<day>\d+)/)
            if match
              @date = Time.local(@year, @month, match[:day].to_i, 23, 59)
              @mode = :reading
            end

          when :reading
            if check_start_line(line)
              buffer_to_result
              parse_md_date(line)
            else
              @buffer.push(line)
            end
          end
        end

        buffer_to_result
        @result
      end

      def buffer_to_result
        unless @buffer.empty?
          @result.push({date: @date, text: @buffer.join})
          @buffer = []
        end
      end

      def parse_md_date(line)
        if md_start_line?(line)
          @date = Time.parse(line.gsub(/日\ .曜日\s/, ' ').gsub(/[年月]/, '/'))
        end
      end

      def check_start_line(line)
        if text_start_line?(line)
          @mode = :find_date
        elsif md_start_line?(line)
          @mode = :reading
        else
          false
        end
      end

      def text_start_line?(line)
        line.strip.start_with?('=' * 8)
      end

      def md_start_line?(line)
        line.strip.start_with?('- 20')
      end
    end
  end
end
