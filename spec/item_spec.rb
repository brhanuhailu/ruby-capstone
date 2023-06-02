require_relative './spec_helper'
describe Book do
  before(:all) do
    @label = Label.new('Fiction', 'blue')
    @item = Item.new('genre', 'author', '2020-01-01', nil)
  end

  describe '#initialize' do
    it 'creates a new item instance' do
      expect(@item).to be_an_instance_of Item
    end

    it 'the genre of the item should be "genre"' do
      expect(@item.genre).to eq('genre')
    end

    it 'the author of the item should be "author"' do
      expect(@item.author).to eq('author')
    end

    it 'the publication date of the book should be "2010-01-01"' do
      expect(@item.published_date).to eq('2020-01-01')
    end

    it 'the label of the book should be a Label instance' do
      expect(@item.label).to be nil
    end
  end

  describe '#can_be_archived?' do
    it 'should return false for less than 10 years' do
      expect(@item.can_be_archived?).to eq(false)
    end

    it 'should return true for more than 10 years' do
      @item.published_date = '2010-01-01'
      expect(@item.can_be_archived?).to eq(true)
    end
  end

  describe '#move_to_archive' do
    it 'should return true if can_be_archived? is true' do
      @item.published_date = '2010-01-01'
      expect(@item.move_to_archive).to eq(true)
    end
  end

  describe '#label=' do
    it 'should add the item to the label' do
      @item.label = @label
      expect(@label.items).to include(@item)
    end
  end

  describe '#author=' do
    it 'should add the item to the author' do
      author = Author.new('John', 'Doe')
      @item.author = author
      expect(author.items).to include(@item)
    end
  end

  describe '#genre=' do
    it 'should add the item to the genre' do
      genre = Genre.new('Fiction')
      @item.genre = genre
      expect(genre.items).to include(@item)
    end
  end
end
