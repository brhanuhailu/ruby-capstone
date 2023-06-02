require 'date'

class Item
  attr_reader :id, :label, :author, :genre
  attr_accessor :published_date, :archived

  def initialize(genre, author, published_date, label = nil)
    @id = Random.rand(1..1000)
    @genre = genre
    @author = author
    @label = label
    @published_date = published_date
    @archived = false
  end

  def can_be_archived?
    age_in_years = Time.now.year - Date.parse(@published_date).year
    age_in_years >= 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_author(self) unless author.items.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end
end
