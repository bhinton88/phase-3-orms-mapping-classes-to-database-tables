require 'bundler'
Bundler.require

require_relative '../lib/song'

# we are assigning DB to a hash that includes a symbol
# we are then able to access this in order to 
# allow us to create a new database and access it
DB = { conn: SQLite3::Database.new("db/music.db") }
