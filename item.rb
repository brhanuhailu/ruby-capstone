class Item
  attr_reader :id, :archived
  attr_accessor :genre, :author, :label, :published_date

  def iniliaze(genre, author, label, published_date)
    @id = Random.rand(1..1000)
    @genre = genre
    @author = author
    @label = label
    @published_date = published_date
    @archived = false
  end

  def can_be_archived?
    age_in_years = Time.now.year - @published_date.year
    age_in_years >= 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
