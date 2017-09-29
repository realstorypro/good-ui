# frozen_string_literal: true

describe DcUi::Configuration, 'configuration' do
  after(:each) do
    DcUi.configuration.ui_file = nil
  end

  it 'should not boot up without implementation file passed' do
    expect { DcUi.boot }.to raise_error(RuntimeError)
  end

  it 'should boot with configuration file passed' do
    expected = expect do
      DcUi.configure do |config|
        config.ui_file = "#{DcUi.root}/lib/shared/ui.yml"
      end
      DcUi.boot
    end
    expected.not_to raise_error
  end

  it 'converts yml file to hashie', boot: true do
    expect(DcUi.configuration.ui_file).to be_a_kind_of(Hashie::Mash)
  end
end
