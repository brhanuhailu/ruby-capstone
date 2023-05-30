require_relative 'book'
require_relative 'label'

class App
  def initialize
    @books = []
    @labels = []
  end

  def list_books
    @books.each do |book|
      puts "#{book.id} - #{book.genre} - #{book.author} - #{book.published_date}"
    end
  end

  def list_labels
    @labels.each do |label|
      puts "#{label.id} - #{label.title} - #{label.color}"
    end
  end

  def create_book
    puts 'Enter genre'
    genre = gets.chomp
    puts 'Enter author'
    author = gets.chomp
    puts 'Enter published date (YYYY-MM-DD))'
    published_date = gets.chomp
    puts 'Enter publisher'
    publisher = gets.chomp
    puts 'Enter cover state'
    cover_state = gets.chomp
    book = Book.new(genre, author, published_date, publisher, cover_state)
    @books << book
    puts 'Book created successfully'
  end

  def create_label
    puts 'Enter title'
    title = gets.chomp
    puts 'Enter color'
    color = gets.chomp
    label = Label.new(title, color)
    @labels << label
    puts 'Label created successfully'
  end

  def exit_app
    puts 'Thanks for using the app!'
    exit
  end
end
