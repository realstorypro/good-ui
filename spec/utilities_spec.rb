# frozen_string_literal: true

describe DcUi::Utilities do
  before(:each) do |example|
    @utils = DcUi::Utilities.instance unless example.metadata[:skip_instance]
  end

  after(:each) do
    @utils = nil
  end

  it 'it is a singleton class', skip_instance: true do
    expect(DcUi::Utilities).to respond_to(:instance)
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