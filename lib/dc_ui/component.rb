module DcUi
  # responsible for the out building of the component
  class Component
    attr_accessor :tag, :css_class, :id, :url, :img, :text, :data, :style, :vue_props

    def initialize(settings)
      @utils = Utilities.instance
      @settings = settings
      set_defaults
      build_component
      transpose_settings %w[data style id tag url img text]
    end

    # sets component defaults
    def set_defaults
      @id = nil
      @url = nil
      @img = nil
      @text = nil
      @data = nil
      @style = nil
      @vue_props = []
      @css_class = ''
    end

    # builds out the component
    def build_component
      build_ui
      build_dynamic
      build_class
      build_responsiveness
      build_name
      build_default_class
      build_vue
      build_vue_props
    end

    # builds out the ui class for the component
    def build_ui
      add_class 'ui' unless off?(:ui)
    end

    # adds dynamic class to the component is the switch is set
    def build_dynamic
      add_class 'dynamic' if on?(:dynamic)
    end

    # builds out css class for the component
    def build_class
      add_class @settings[:class] if @settings.key?(:class)
    end

    # builds out the reponsive css classes
    def build_responsiveness
      add_class build_only if @settings.key?(:only)
      add_class build_size if @settings.key?(:size)

      sizes = %i[computer tablet mobile]
      sizes.each do |device|
        add_class build_size(device) if @settings.key?(device)
      end
    end

    # builds out the name for the compnent
    def build_name
      return unless @settings.key?(:name)
      add_class @settings[:name]
      add_data :name, @settings[:name].parameterize.underscore
    end

    # builds out a default class for the component
    def build_default_class
      add_class @settings[:css_class] if @settings.key?(:css_class)
    end

    # enalbes vue in the data array
    def build_vue
      add_data :vue, true if on?(:vue)
    end

    # builds vue properties
    def build_vue_props
      if @settings.key?(:v)
        @settings[:v].each do |vue_prop|
          vue_props << { "v-#{vue_prop[0]}":  vue_prop[1] }
        end
      end
    end


    private

    def transpose_settings(items)
      items.each do |item|
        instance_variable_set("@#{item}", @settings[item.to_sym])
      end
    end

    # appends class to the css_clss object
    def add_class(klass)
      css_class << ' ' + klass
    end

    # builds out the class markup for 'only' type display
    def build_only
      "#{@settings[:only]} only"
    end

    # builds out the class markup for the size
    def build_size(device = nil)
      return @utils.number_in_words(@settings[:size]) if device.equal? nil
      "#{@utils.number_in_words(@settings[device])} wide #{device}"
    end

    # appds items to the data hash
    def add_data(name, value)
      # intialize data hash if one doesn't exist
      @settings[:data] = {} if @settings[:data].nil?

      @settings[:data][name] = value
    end

    # checks if the key is off
    # todo: extract into a gem
    # - use syntax like @settings[key].on?
    # - make sure the [method]? is metaprogrammed on method_missing to map to the key
    def off?(key)
      return true if @settings[key].equal? :off
      false
    end

    # checks if the key is on
    def on?(key)
      return true if @settings[key].equal? :on
      false
    end
  end
end
