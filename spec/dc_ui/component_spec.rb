# frozen_string_literal: true

describe DcUi::Component, 'component creation' do
  it 'it can be created' do
    component = DcUi::Component.new({})
    expect(component).to be_a_kind_of(DcUi::Component)
  end
end

describe DcUi::Component, 'component abilities' do
  before(:each) do
    @utils = DcUi::Utilities.instance
    @settings = @utils.merge_defaults('grid', class: 'round', text: 'test')
    @component = DcUi::Component.new(@settings)
  end

  after(:each) do
    @settings = nil
    @component = nil
  end

  it 'is an instance of component' do
    expect(@component).to be_an_instance_of(DcUi::Component)
  end

  it 'applies a ui key by default' do
    expect(@component.css_class).to include('ui')
  end

  it 'renders a default component class' do
    expect(@component.css_class).to include('grid')
  end

  it 'renders a passed class' do
    expect(@component.css_class).to include('round')
  end

  it 'allows for a ui key to be turned off' do
    settings = @utils.merge_defaults('grid', class: 'round', ui: :off)
    component = DcUi::Component.new(settings)
    expect(component.css_class).to_not include('ui')
  end

  it 'adds a dynamic css class' do
    settings = @utils.merge_defaults('grid', class: 'round', dynamic: :on)
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('dynamic')
  end

  it 'can build a responsive column' do
    settings = @utils.merge_defaults('column', size: 16)
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('sixteen')
  end

  it 'can build a responsive mobile column' do
    settings = @utils.merge_defaults('column', mobile: 6)
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('six wide mobile')
  end

  it 'can build a responsive tablet column' do
    settings = @utils.merge_defaults('column', tablet: 5)
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('five wide tablet')
  end

  it 'can build a responsive computer column' do
    settings = @utils.merge_defaults('column', computer: 2)
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('two wide computer')
  end

  it 'can build a computer only column' do
    settings = @utils.merge_defaults('column', only: :computer)
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('computer only')
  end

  it 'accepts name and generates class & data' do
    settings = @utils.merge_defaults('column', name: 'sidebar name')
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('sidebar')
    expect(component.data[:name]).to include('sidebar_name')
  end

end
