RSpec.shared_examples 'a repository class' do
  describe 'Instance Methods' do
    it 'has a #save method' do
      expect(subject).to respond_to(:save)
    end
  end

  describe 'Class Methods' do
    it 'has a .first method' do
      expect(described_class).to respond_to(:first)
    end

    it 'has a .delete_all method' do
      expect(described_class).to respond_to(:delete_all)
    end
  end
end
