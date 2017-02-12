RSpec.shared_examples 'a foreign exchange rates collection' do
  it 'has a date for the fx rates, that is parsed from string to Date' do
    expect(subject).to respond_to(:date)
    expect(subject.date).to eql(Date.parse(date))
  end

  it 'has a source from where the rates came from' do
    expect(subject).to respond_to(:source)
    expect(subject.source).to eql(source)
  end

  it 'has a collection of fx_rates' do
    expect(subject).to respond_to(:fx_rates)
  end

  it 'has an empty rates collection by default' do
    expect(subject.fx_rates).to be_empty
  end

  context 'When passing rates' do
    let(:raw_rate) { double('rate', currency: 'GBP', rate: '0.8529') }
    let(:raw_rates) { [raw_rate] }

    subject { described_class.new(date: date, source: source, raw_rates: raw_rates) }

    it 'creates a fx rates collection with normalized data' do
      rate = subject.fx_rates.first
      expect(rate.currency).to eq :GBP
      expect(rate.rate).to eq BigDecimal(raw_rate.rate)
    end
  end

end
