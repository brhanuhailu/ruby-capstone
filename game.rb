require_relative 'item'
require 'date'

class Game < Item
  attr_accessor :id, :game_name, :multiplayer, :last_played_at, :publish_date

  def initialize(game_name, last_played_at, publish_date, multiplayer)
    super(nil, nil, nil, publish_date)
    @id = id || Random.rand(1..1000)
    @game_name = game_name
    @multiplayer = multiplayer
    @last_played_at = last_played_at
    @publish_date = Date.parse(publish_date)
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    age_in_years = Time.now.year - @last_played_at.year
    age_in_years >= 2
  end
end
