module DcUi::Helpers
  # ui factory
  def ui(name, args = {}, &block)
    settings = DcUi::Utilities.instance.merge_defaults(name, args)
    component = DcUi::Component.new(settings)

    # throw an error if the url is also passed
    raise ArgumentError.new 'Can not pass `img` and `url` at the same time' if component.url && component.img

    if component.img
      # build out a image tag if img is passed
      build_ui_image(component)
    elsif component.url
      # build out a url if one is passed
      build_ui_link(component, &block)
    else
      # builds out regular content tag
      build_ui_content(component, &block)
    end
  end

  def method_missing(m, *args, &block)
    if DcUi::Utilities.instance.component_defined?(m)
      define_scope_of_class = class << self; self; end # giving access to m inside define_method
      define_scope_of_class.class_eval do
        define_method m.to_s do |method_args = {}, &method_block|
          ui m.to_s, method_args, &method_block
        end
      end
      ui m.to_s, args[0], &block
    else
      super
      raise ArgumentError.new("Method `#{m}` doesn't exist.")
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s || super
  end

  private

  def build_ui_image(component)
    image_tag component.img, class: component.css_class, id: component.id, data: component.data, style: component.style
  end

  def build_ui_link(component, &block)
    link_to component.url, class: component.css_class, id: component.id, data: component.data, style: component.style do
      if component.text.nil?
        capture(&block) if block_given?
      else
        component.text
      end
    end
  end

  def build_ui_content(component, &block)
    content_tag component.tag, class: component.css_class, id: component.id, data: component.data, style: component.style do
      if component.text.nil?
        capture(&block) if block_given?
      else
        component.text
      end
    end
  end
end