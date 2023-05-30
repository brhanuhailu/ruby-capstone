require_relative 'item'

class Book < Item
  def initialize(genre, author, published_date, publisher, cover_state)
    super(genre, author, published_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    result = super
    result || cover_state == 'bad'
  end
end
