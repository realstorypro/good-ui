# frozen_string_literal: true

describe GoodUi::Configuration, 'configuration' do
  it 'should not boot up without implementation file passed', skip_boot: true do
    expect { GoodUi.boot }.to raise_error(RuntimeError)
  end

  it 'should boot with configuration file passed' do
    expected = expect do
      GoodUi.configure do |config|
        config.ui_file = "#{GoodUi.root}/lib/shared/ui.yml"
      end
      GoodUi.boot
    end
    expected.not_to raise_error
  end

  it 'converts yml file to hashie' do
    expect(GoodUi.configuration.ui_file).to be_a_kind_of(Hashie::Mash)
  end
end
