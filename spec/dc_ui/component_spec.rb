# frozen_string_literal: true

describe DcUi::Component, 'component creation' do
  it 'it can be created' do
    component = DcUi::Component.new({})
    expect(component).to be_a_kind_of(DcUi::Component)
  end
end

describe DcUi::Component, 'default component abilities' do
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

  it 'sets a default tag' do
    expect(@component.tag).to include('div')
  end
end

# rubocop:disable BlockLength
describe DcUi::Component, 'custom default component abilities' do
  before(:each) do
    @utils = DcUi::Utilities.instance
  end

  it 'allows for function call without arguments' do
    settings = @utils.merge_defaults('grid')
    component = DcUi::Component.new(settings)
    expect(component.css_class).to include('ui grid')
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

  it 'allows for vue to be enabled' do
    settings = @utils.merge_defaults('column', vue: :on)
    component = DcUi::Component.new(settings)
    expect(component.data[:vue]).to be(true)
  end

  it 'allows for style to be passed' do
    settings = @utils.merge_defaults('column', style: 'font-weight: bold;')
    component = DcUi::Component.new(settings)
    expect(component.style).to include('font-weight: bold;')
  end

  it 'allows for id to be set' do
    settings = @utils.merge_defaults('column', id: 'woot')
    component = DcUi::Component.new(settings)
    expect(component.id).to include('woot')
  end

  it 'allows for tag to be set' do
    settings = @utils.merge_defaults('column', tag: 'h1')
    component = DcUi::Component.new(settings)
    expect(component.tag).to include('h1')
  end

  it 'allows for url to be set' do
    settings = @utils.merge_defaults('column', url: 'http://www.google.com')
    component = DcUi::Component.new(settings)
    expect(component.url).to include('http://www.google.com')
  end

  it 'allows for alt to be set' do
    settings = @utils.merge_defaults('column', alt: 'column2')
    component = DcUi::Component.new(settings)
    expect(component.alt).to include('column2')
  end

  it 'allows for title to be set' do
    settings = @utils.merge_defaults('column', title: 'title2')
    component = DcUi::Component.new(settings)
    expect(component.title).to include('title2')
  end

  it 'allows for image to be set' do
    settings = @utils.merge_defaults('column', img: 'test.gif')
    component = DcUi::Component.new(settings)
    expect(component.img).to include('test.gif')
  end

  it 'allows for text to be set' do
    settings = @utils.merge_defaults('column', text: 'hey bud!')
    component = DcUi::Component.new(settings)
    expect(component.text).to include('hey bud!')
  end
end
# rubocop:enable BlockLength
