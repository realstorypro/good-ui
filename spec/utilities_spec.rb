# frozen_string_literal: true

describe DcUi::Utilities do
  it 'it is a singleton class', skip_instance: true do
    expect(DcUi::Utilities).to respond_to(:instance)
  end
end

describe DcUi::Utilities, 'number to text conversion' do
  before(:each) do
    @utils = DcUi::Utilities.instance
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

describe DcUi::Utilities, 'component building' do
  before(:each) do
    @utils = DcUi::Utilities.instance
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

end
