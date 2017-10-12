module DcUi
  # helper module that gets included into a gem
  module Helpers
    # ui factory
    def ui(name, args = {}, &block)
      settings = DcUi::Utilities.instance.merge_defaults(name, args)
      component = DcUi::Component.new(settings)
      render_component(component, &block)
    end

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

    def render_component(component, &block)
      # throw an error if the url & img are both passed in
      error_msg = 'Can not pass `img` and `url` at the same time. You must choose ...'
      raise ArgumentError, error_msg if component.url && component.img

      if component.img
        build_image_component(component)
      elsif component.url
        build_link_component(component, &block)
      else
        build_tag_component(component, &block)
      end
    end

    def build_image_component(c)
      image_tag c.img, class: c.css_class, id: c.id, data: c.data, style: c.style
    end

    def build_link_component(c, &block)
      link_to c.url, class: c.css_class, id: c.id, data: c.data, style: c.style do
        if c.text.nil?
          capture(&block) if block_given?
        else
          c.text
        end
      end
    end

    def build_tag_component(c, &block)
      content_tag c.tag, class: c.css_class, id: c.id, data: c.data, style: c.style do
        if c.text.nil?
          capture(&block) if block_given?
        else
          c.text
        end
      end
    end
  end
end
