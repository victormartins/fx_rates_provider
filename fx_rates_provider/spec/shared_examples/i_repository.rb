RSpec.shared_examples 'a repository class' do
  describe 'Instance Methods' do
    it 'has a #save method' do
      expect(subject).to respond_to(:save)
    end
  end

  describe 'Class Methods' do
    it 'has a .count method' do
      expect(described_class).to respond_to(:count)
    end

    it 'has a .first method' do
      expect(described_class).to respond_to(:first)
    end

    it 'has a .delete_all method' do
      expect(described_class).to respond_to(:delete_all)
    end

    it 'has a .last_updated_at method' do
      expect(described_class).to respond_to(:last_updated_at)
    end

    it 'has a .last_updated_at is 1900-1-1 by default' do
      expect(described_class.last_updated_at).to eql Date.new(1900, 1, 1)
    end
  end
end
