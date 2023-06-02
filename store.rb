require_relative './src/music/music_album'
require_relative './src/music/genre'
require_relative './app'
require 'json'

module Storage
  def save_music_albums; end

  def load_music_albums; end

  def save_genres; end

  def load_genres; end
end
