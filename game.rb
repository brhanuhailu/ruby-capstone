class Game < Item
  attr_accessor :multiplayer, :last_played_date

  def initialize(genre, author, published_date, multiplayer, last_played_date)
    super(genre, author, label, published_date)
    @multiplayer = multiplayer
    @last_played_date = last_played_date
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    age_in_years = Time.now.year - @last_played_date.year
    age_in_years >= 10
  end
end
