
require_relative 'book'
require_relative 'label'
require_relative 'item'
require_relative 'game'
require_relative 'author'
require 'json'
require 'date'

class App
  def initialize
    @books = []
    @labels = []
    @games = []
    @authors = []
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
    puts 'Enter author'
    author = gets.chomp
    puts 'Enter published date (YYYY-MM-DD))'
    published_date = gets.chomp
    puts 'Enter publisher'
    publisher = gets.chomp
    puts 'Enter cover state'
    cover_state = gets.chomp
    puts 'Enter label title'
    label_title = gets.chomp
    puts 'Enter label color'
    label_color = gets.chomp
    label = Label.new(label_title, label_color)
    book = Book.new(author, published_date, publisher, cover_state, label)
    @books << book
    @labels << label
    puts 'Book created successfully'
  end

  def list_games
    if @games.empty?
      puts 'No games found in the system currently'
    else
      puts '=================================================================:'
      puts 'List of Games:'
      puts 'ID - Game Name - Last Played Date - Published Date - Multiplayer'
      @games.each do |game|
        puts "#{game.id} - #{game.game_name} - #{game.last_played_at} - #{game.publish_date} - #{game.multiplayer}"
        puts '=================================================================:'
      end
    end
  end

  def list_authors
    if @authors.empty?
      puts 'No authors found in the system currently'
    else
      puts '=============================================:'
      puts 'List of Authors:'
      puts 'ID - First Name - Last Name'
      @authors.each do |author|
        puts "#{author.id} - #{author.first_name} - #{author.last_name}"
        puts '=============================================:'
      end
    end
  end

  def create_games
    puts 'write Name of the game'
    game_name = gets.chomp
    puts 'Write last played date (YYYY-MM-DD))'
    last_played_at = gets.chomp
    puts 'Enter published date (YYYY-MM-DD))'
    publish_date = gets.chomp
    puts 'Enter multiplayer'
    multiplayer = gets.chomp
    puts 'Enter first name'
    first_name = gets.chomp
    puts 'Enter last name'
    last_name = gets.chomp
    author = Author.new(first_name, last_name)
    @authors << author
    game = Game.new(game_name, last_played_at, publish_date, multiplayer)
    @games << game
    puts 'Game is created successfully'
  end

  def exit_app
    puts 'Thanks for using the app!'
    exit
  end
end

require_relative 'book'
require_relative 'label'
require_relative './store/preserve_data'
require 'json'

class App
  def initialize
    @store = PreserveData.new
    @books = File.empty?('./store/books.json') ? [] : @store.load_data('./store/books.json')
    @labels = File.empty?('./store/labels.json') ? [] : @store.load_data('./store/labels.json')
  end

  def list_books
    @books.each do |book|
      puts "#{book['id']} - #{book['author']} - #{book['published_date']}"
    end
  end

  def list_labels
    @labels.each do |label|
      puts "#{label['id']} - #{label['title']} - #{label['color']}"
    end
  end

  def create_book
    puts 'Enter author'
    author = gets.chomp
    puts 'Enter published date (YYYY-MM-DD))'
    published_date = gets.chomp
    puts 'Enter publisher'
    publisher = gets.chomp
    puts 'Enter cover state'
    cover_state = gets.chomp
    puts 'Enter label title'
    label_title = gets.chomp
    puts 'Enter label color'
    label_color = gets.chomp
    label = create_label(label_title, label_color)
    book = create_book_object(author, published_date, publisher, cover_state, label)
    @books << book
    @labels << label
    @store.save_data(@books, './store/books.json')
    @store.save_data(@labels, './store/labels.json')
    puts 'Book created successfully'
  end

  def create_label(title, color)
    label = Label.new(title, color)
    { 'id' => label.id, 'title' => label.title, 'color' => label.color }
  end

  def create_book_object(author, published_date, publisher, cover_state, label)
    book = Book.new(author, published_date, publisher, cover_state, label)
    {
      'id' => book.id,
      'author' => book.author,
      'published_date' => book.published_date,
      'publisher' => book.publisher,
      'cover_state' => book.cover_state,
      'label' => book.label
    }
  end

  def exit_app
    puts 'Thanks for using the app!'
    exit
  end
end

