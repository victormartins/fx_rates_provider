RSpec.shared_examples 'a foreign exchange rates collection' do
  let(:date) { '2017-2-11' }
  let(:source) { 'test' }
  subject { described_class.new(date: date, source: source) }

  it 'has a date for the fx rates, that is parsed from string to Date' do
    expect(subject).to respond_to(:date)
    expect(subject.date).to eql(Date.parse(date))
  end

  it 'has a source from where the rates came from' do
    expect(subject).to respond_to(:source)
    expect(subject.source).to eql(source)
  end

  it 'has a collection of rates' do
    expect(subject).to respond_to(:rates)
  end

  it 'has an empty rates collection by default' do
    expect(subject.rates).to be_empty
  end

  describe '#add_rate' do
    it 'hads a rate to the collection' do
      expect { subject.add_rate(currency: 'GBP', rate: '0.8529') }.to change { subject.rates.count }.by(1)
    end

    it 'creates a rate with the right API and normalized data' do
      subject.add_rate(currency: 'GBP', rate: '0.8529')
      rate = subject.rates.first
      expect(rate.currency).to eq :GBP
      expect(rate.rate).to eq BigDecimal('0.8529')
    end
  end

end
