module Convdayone
  OPTIONS = [:date, :starred, :photo_path, :journal_file].freeze

  class CLI
    def self.create(content, options = {})
      raise '`dayone-cli` is not found. install from ' unless !`type dayone`.empty?
      `echo '#{content}' | dayone #{cli_option(options)} new`
    end

    def self.cli_option(options)
      OPTIONS.each_with_object([]) { |key, result|
        if options.key?(key)
          result.push "--#{key.to_s.gsub('_', '-')}='#{options[key]}'"
        end
      }.join(' ')
    end
  end
end
