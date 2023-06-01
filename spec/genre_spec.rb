require 'rspec'
require 'json'

describe Genre do
  let(:genre_name) { 'Comedy' }
  let(:item) { double('Item') }
  let(:genre) { Genre.new(genre_name) }

  describe '#initialize' do
    it 'should set the name' do
      expect(genre.name).to eq(genre_name)
    end

    it 'should generate an id' do
      expect(genre.id).to be_a(Integer)
    end

    it 'should initialize an empty items collection' do
      expect(genre.items).to be_empty
    end
  end

  describe '#add_item' do
    it 'should add the item to the items collection' do
      genre.add_item(item)
      expect(genre.items).to include(item)
    end

    it 'should set self as a property of the item object' do
      expect(item).to receive(:genres=).with(genre)
      genre.add_item(item)
    end
  end
end
