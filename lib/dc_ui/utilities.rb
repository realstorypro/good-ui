# frozen_string_literal: true

module DcUi
  # Singleton with utilities used by DC-UI
  class Utilities
    include Singleton

    def initialize
      @config = DcUi.configuration.ui_file
    end

    # Checks if the component exists inside the config file
    def component_defined?(component)
      return true if @config.defaults[component]
      false
    end

    # Merges passed options with defaults defined in the config file
    def merge_defaults(component, args={})
      raise "component :: #{component} :: is undefined in the ui.yml" unless component_defined?(component)

      # special case where only a single string is passed as an argument
      # we're treating it as the same as setting a class
      args = { class: args } if !args.nil? && args.is_a?(String)

      defaults = @config.defaults[component]

      defaults.each do |default|
        name = default[0].to_sym
        value = default[1]

        if args.nil? || args.empty?
          args = {}
          args[name] = value
        else
          args[name] = value unless args.key?(name)
        end
      end
      args

    end

    # Converts numbers into words
    # It seems to be having issues with larger valeus such as 1001
    # rubocop:disable all
    def number_in_words(int)
      numbers_to_name = {
          1_000_000 => 'million', 1000 => 'thousand', 100 => 'hundred', 90 => 'ninety', 80 => 'eighty', 70 => 'seventy', 60 => 'sixty', 50 => 'fifty', 40 => 'forty',
          30 => 'thirty', 20 => 'twenty', 19 => 'nineteen', 18 => 'eighteen', 17 => 'seventeen', 16 => 'sixteen', 15 => 'fifteen', 14 => 'fourteen', 13 => 'thirteen',
          12 => 'twelve', 11 => 'eleven', 10 => 'ten', 9 => 'nine', 8 => 'eight', 7 => 'seven', 6 => 'six', 5 => 'five', 4 => 'four', 3 => 'three', 2 => 'two', 1 => 'one'
      }
      str = ''
      numbers_to_name.each do |num, name|
        if int.zero?
          return str
        elsif int.to_s.length == 1 && (int / num).positive?
          return str + name.to_s
        elsif int < 100 && (int / num).positive?
          return str + name.to_s if (int % num).zero?
          return str + name.to_s + ' ' + number_in_words(int % num)
        elsif (int / num).positive?
          return str + number_in_words(int / num) + ' ' + name.to_s + number_in_words(int % num)
        end
      end
    end
    # rubocop:enable all
  end
end
