module DcUi
  # helper module that gets included into a gem
  module Helpers
    # rubocop:disable MethodLength
    def method_missing(m, *args, &block)
      if DcUi::Utilities.instance.component_defined?(m)
        # giving access to m inside define_method
        define_scope_of_class = class << self; self; end
        define_scope_of_class.class_eval do
          define_method m.to_s do |method_args = {}, &method_block|
            ui m.to_s, method_args, &method_block
          end
        end
        ui m.to_s, args[0], &block
      else
        super
      end
    end
    # rubocop:enable MethodLength

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s || super
    end

    private

    # ui factory
    def ui(name, args = {}, &block)
      settings = DcUi::Utilities.instance.merge_defaults(name, args)
      component = DcUi::Component.new(settings)
      render_component(component, &block)
    end

    def render_component(component, &block)
      # throw an error if the url & img are both passed in
      error_msg = 'Can not pass `img` and `url` at the same time. You must choose ...'
      raise ArgumentError, error_msg if component.url && component.img

      if component.img
        render_image_component(component)
      elsif component.url
        render_link_component(component, &block)
      else
        render_tag_component(component, &block)
      end
    end

    # renders the image component
    def render_image_component(component)
      arguments = build_arguments(component)
      image_tag component.img, arguments
    end

    # renders the link component
    def render_link_component(component, &block)
      arguments = build_arguments(component)
      link_to component.url, arguments do
        if component.text.nil?
          raw(capture(&block)) if block_given?
        else
          component.text
        end
      end
    end

    # renders the tag component
    def render_tag_component(component, &block)
      arguments = build_arguments(component)

      content_tag component.tag, arguments do
        if component.text.nil?
          raw(capture(&block)) if block_given?
        else
          component.text
        end
      end
    end

    # constructs the arguments from a component
    def build_arguments(component)
      arguments = {}
      arguments[:class] = component.css_class
      arguments[:id] = component.id
      arguments[:data] = component.data
      arguments[:style] = component.style
      return arguments if component.vue_props.empty?

      component.vue_props.each do |prop|
        arguments[prop.keys.first] = prop.values.first
      end
      arguments
    end
  end
end
