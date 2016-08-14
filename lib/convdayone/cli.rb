require 'shellwords'

module Convdayone
  OPTIONS = [:date, :starred, :photo_path, :journal_file].freeze

  class CLI
    def self.create(content, options = {})
      raise '`dayone-cli` is not found. install from ' unless !`type dayone`.empty?
      IO.popen("dayone #{cli_option(options)} new", "r+") do |io|
        io.puts(escape_string(content))
        io.close_write
        io.read
      end
    end

    def self.escape_string(string)
      Shellwords.escape(string)
    end

    def self.cli_option(options)
      OPTIONS.each_with_object([]) { |key, result|
        if options.key?(key)
          value = options[key]

          if key == :date
            value = value.utc.strftime('%F %T')
          end

          result.push "--#{key.to_s.gsub('_', '-')}='#{value}'"
        end
      }.join(' ')
    end
  end
end
