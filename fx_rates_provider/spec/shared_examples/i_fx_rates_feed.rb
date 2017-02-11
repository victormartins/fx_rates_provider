RSpec.shared_examples 'a foreign exchange rates feed' do
  it 'has a URL constant' do
    expect(described_class::URL).to_not be_nil
  end

  it 'has a get method' do
    expect(subject).to respond_to(:get)
  end

  it 'has has a fx_rates method'
  it 'has a succesful? method'
  it 'has an errors method'
end
