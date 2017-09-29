require 'byebug'

describe DcUi::Configuration, 'configuration' do
  it 'should not boot up without implementation file passed' do
    expect { DcUi.boot }.to raise_error(RuntimeError)
  end

  it 'should boot with configuration file passed' do
    expected = expect do
      DcUi.configure do |config|
        config.ui_file = 'ui'
      end
      DcUi.boot
    end
    expected.not_to raise_error
  end
end
