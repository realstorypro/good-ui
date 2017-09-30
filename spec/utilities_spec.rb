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

end