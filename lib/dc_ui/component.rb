module DcUi
  # responsible for the out building of the component
  class Component
    attr_accessor :tag, :css_class, :id, :url, :img, :text, :data, :style

    def initialize(settings)
      @utils = Utilities.instance
      @settings = settings
      @id = nil
      @url = nil
      @img = nil
      @text = nil
      @data = nil
      @style = nil
      @css_class = ''
      build
    end

    def build
      # functions that affect the component class
      build_ui
      build_dynamic
      build_class
      build_responsiveness
      build_name
      build_default_class

      # builds out other parts of the component
      build_vue
      build_data
      build_style
      build_id
      build_tag
      build_url
      build_img
      build_text
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
      add_class build_size(:computer) if @settings.key?(:computer)
      add_class build_size(:tablet) if @settings.key?(:tablet)
      add_class build_size(:mobile) if @settings.key?(:mobile)
    end

    # builds out the name for the compnent
    def build_name
      if @settings.key?(:name)
        add_class @settings[:name]
        add_data :name, @settings[:name].parameterize.underscore
      end
    end

    # builds out a default class for the component
    def build_default_class
      add_class @settings[:css_class] if @settings.key?(:css_class)
    end

    # enalbes vue in the data array
    def build_vue
      add_data :vue, true if on?(:vue)
    end

    # builds data for the component
    def build_data
      @data = @settings[:data]
    end

    # builds style for the component
    def build_style
      @style = @settings[:style]
    end

    # builds id for the component
    def build_id
      @id = @settings[:id] if @settings.key?(:id)
    end

    # builds tag for the component
    def build_tag
      @tag = @settings[:tag]
    end

    # builds url for the component
    def build_url
      @url = @settings[:url]
    end

    # builds img for the component
    def build_img
      @img = @settings[:img]
    end

    # builds text for the component
    def build_text
      @text = @settings[:text]
    end


    private

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
