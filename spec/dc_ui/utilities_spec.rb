# frozen_string_literal: true

describe GoodUi::Utilities do
  it 'it is a singleton class', skip_instance: true do
    expect(GoodUi::Utilities).to respond_to(:instance)
  end
end

describe GoodUi::Utilities, 'number to text conversion' do
  before(:each) do
    @utils = GoodUi::Utilities.instance
  end

  after(:each) do
    @utils = nil
  end

  it 'converts small even integers into words' do
    expect(@utils.number_in_words(2)).to eq('two')
  end

  it 'converts small odd integers into words' do
    expect(@utils.number_in_words(15)).to eq('fifteen')
  end

  it 'converts large(ish) odd integers into words' do
    expect(@utils.number_in_words(51)).to eq('fifty one')
  end

  it 'retruns an empty string if the number is zero' do
    expect(@utils.number_in_words(0)).to eq('')
  end
end

describe GoodUi::Utilities, 'component building' do
  before(:each) do
    @utils = GoodUi::Utilities.instance
  end

  after(:each) do
    @utils = nil
  end

  it 'returns `true` if the component exists within the config file' do
    expect(@utils.component_defined?(:container)).to be(true)
  end

  it 'returns `false` if the component doesnt within the config file' do
    expect(@utils.component_defined?(:undefined_component)).to be(false)
  end
end

# rubocop:disable Metrics/BlockLength
describe GoodUi::Utilities, 'merges settings' do
  before(:each) do
    @utils = GoodUi::Utilities.instance
  end

  after(:each) do
    @utils = nil
  end

  it 'raises an error when trying to merge settings for a non existing component' do
    expect { @utils.merge_defaults('undefined_component') }.to raise_error(RuntimeError)
  end

  it 'doesnt returns non existing settings if no arguments are passed' do
    component = @utils.merge_defaults('grid')
    expect(component).to_not include(:nonexisting)
  end

  it 'returns tag & css_class settings if no arguments are passed' do
    component = @utils.merge_defaults('grid')
    expect(component).to include(:tag, :css_class)
  end

  it 'returns correct tag if no arguments are passed' do
    component = @utils.merge_defaults('grid')
    expect(component[:tag]).to eql('div')
  end

  it 'returns correct css_class if no arguments are passed' do
    component = @utils.merge_defaults('grid')
    expect(component[:css_class]).to eql('grid')
  end

  it 'allows for the tag to be overwritten' do
    component = @utils.merge_defaults('grid', tag: 'h4')
    expect(component[:tag]).to eql('h4')
  end

  it 'allows for the css_class to be overwritten' do
    component = @utils.merge_defaults('grid', css_class: 'non grid')
    expect(component[:css_class]).to eql('non grid')
  end

  it 'picks up additional boolean options' do
    component = @utils.merge_defaults('grid', vue: true)
    expect(component[:vue]).to be(true)
  end

  it 'picks up additional string options' do
    component = @utils.merge_defaults('grid', arbitrary: 'asd')
    expect(component[:arbitrary]).to eql('asd')
  end

  it 'can receive a single string option and convert it into a class argument' do
    component = @utils.merge_defaults('grid', 'single class')
    expect(component[:class]).to eql('single class')
  end
  # rubocop:enable Metrics/BlockLength
end
