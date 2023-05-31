require_relative '../author'
require_relative '../item'

RSpec.describe Author do
  describe '#add_author' do
    let(:author) { Author.new('John', 'Doe') }
    let(:item) { Item.new('Example Item') }

    it 'adds an item to the author' do
      author.add_author(item)
      expect(author.items).to include(item)
    end

    it 'sets the author of the item to the current author' do
      author.add_author(item)
      expect(item.author).to eq(author)
    end
  end

  describe '#full_name' do
    let(:author) { Author.new('John', 'Doe') }

    it 'returns the full name of the author' do
      expect(author.full_name).to eq('John Doe')
    end
  end
end
