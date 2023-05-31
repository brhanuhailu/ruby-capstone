require_relative 'book'
require_relative 'label'
require_relative 'item'
require_relative 'game'
require_relative './store/preserve_data'
require_relative 'author'
require 'json'
require 'date'
require_relative './src/genre'
require_relative './src/music_album'

class App
  def initialize
    @store = PreserveData.new
    @books = File.empty?('./store/books.json') ? [] : @store.load_data('./store/books.json')
    @labels = File.empty?('./store/labels.json') ? [] : @store.load_data('./store/labels.json')
    @games = File.empty?('./store/games.json') ? [] : @store.load_data('./store/games.json')
    @authors = File.empty?('./store/authors.json') ? [] : @store.load_data('./store/authors.json')
    @genre = File.empty?('./store/genre.json') ? [] : @store.load_data('./store/genre.json')
    @music_albums = File.empty?('./store/music_albums.json') ? [] : @store.load_data('./store/music_albums.json')
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

  def list_games
    if @games.empty?
      puts 'No games found in the system currently'
    else
      puts '=================================================================:'
      puts 'List of Games:'
      puts '=================================================================:'
      puts 'ID - Game Name - Last Played Date - Published Date - Multiplayer'
      @games.each do |game|
        puts "#{game['id']} - #{game['game_name']} - #{game['last_played_at']} - #{game['publish_date']} - #{game['multiplayer']}"
      end
      puts '=================================================================:'
    end
  end

  def list_authors
    if @authors.empty?
      puts 'No authors found in the system currently'
    else
      puts '=============================================:'
      puts 'List of Authors:'
      puts '=============================================:'
      puts 'ID - First Name - Last Name'
      @authors.each do |author|
        puts "#{author['id']} - #{author['first_name']} - #{author['last_name']}"
      end
      puts '=============================================:'
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
    author = create_author(first_name, last_name)
    @authors << author
    @store.save_data(@authors, './store/authors.json')
    game = create_game_object(game_name, last_played_at, publish_date, multiplayer)
    @games << game
    @store.save_data(@games, './store/games.json')
    puts 'Game is created successfully'
  end

  def create_author(first_name, last_name)
    author = Author.new(first_name, last_name)
    {
      'id' => author.id,
      'first_name' => author.first_name,
      'last_name' => author.last_name
    }
  end

  def create_game_object(game_name, last_played_at, publish_date, multiplayer)
    game = Game.new(game_name, last_played_at, publish_date, multiplayer)
    {
      'id' => game.id,
      'game_name' => game.game_name,
      'last_played_at' => game.last_played_at,
      'publish_date' => game.publish_date,
      'multiplayer' => game.multiplayer
    }
  end

  def add_music_album
    puts 'Album name: '
    name = gets.chomp
    puts 'Genre: '
    genre_name = gets.chomp
    @genres.push(Genre.new(genre_name))
    store_genre_data

    puts 'Date of publish [Enter date in format (yyyy-mm-dd)]'
    publish_date = gets.chomp

    puts 'Is it available on Spotify? Y/N'
    on_spotify = gets.chomp.downcase
    case on_spotify
    when 'y'
      @music_albums.push(MusicAlbum.new(name, publish_date, true))
    when 'n'
      @music_albums.push(MusicAlbum.new(name, publish_date, false))
    end
    puts 'Music album created'
    store_music_data
  end

  def albums
    music_data = get_data('./store/music_albums.json')
    puts 'No music found' if music_data.empty?
    music_data.each do |music_album|
      puts "Album_name: #{music_album['music_name']} | On_spotify: #{music_album['music_on_spotify']}"
    end
  end

  def genres
    data = get_data('./store/genres.json')
    puts 'No genre found' if data.empty?
    data.each do |genre|
      puts "Genre name: #{genre['genre_name']}"
    end
  end

  def store_music_data
    array = []
    @music_albums.each do |music|
      array << {
        music_id: music.id,
        music_name: music.name,
        music_on_spotify: music.on_spotify

      }
    end
    update_data(array, './store/music_albums.json')
  end

  def store_genre_data
    array = []
    @genres.each do |genre|
      array << {
        genre_id: genre.id,
        genre_name: genre.name
      }
    end
    update_data(array, './store/genres.json')
  end
end

  def exit_app
    puts 'Thanks for using the app!'
    exit
  end
end
