RSpec.shared_examples 'a persistable object' do
  describe 'Instance Methods' do
    it 'has a #save method' do
      expect(subject).to respond_to(:save)
    end

    it 'has a #valid? method' do
      expect(subject).to respond_to(:valid?)
    end

    it 'has a #errors method' do
      expect(subject).to respond_to(:errors)
    end
  end
end
