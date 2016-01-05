require 'csv'

module Convdayone
  class MomentDiary
    def self.import(file)
      raise "[#{file}] not found" unless File.exists?(file)

      rows = CSV.read(file).sort { |a, b| a[2] <=> b[2] }

      rows.each do |row|
        text = row[1]
        date = row[2]

        next if text == 'Text'

        begin
          date = Time.parse(date)
        rescue
          raise "invalid date: [#{date}]"
        end

        puts "#{date.strftime('%F %T')} : #{text[0 .. 60].gsub(/[\r\n]/, '')}"

        Convdayone::CLI.create(text, date: date)
      end
    end
    ''
  end
end
