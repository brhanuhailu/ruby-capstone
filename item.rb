require 'date'
require_relative 'label'

class Item
  attr_reader :id, :archived, :label
  attr_accessor :genre, :author, :published_date

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
    label.add_item(self)
  end
end
