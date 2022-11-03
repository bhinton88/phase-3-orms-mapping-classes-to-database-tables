class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  # here we are calling a CLASS method to CREATE the table if it does 
  # not already exist 

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES (?,?)
      SQL

      # inserts the song into the database
      DB[:conn].execute(sql, self.name, self.album)

      # gets the songs ID from the database and saves it to the Ruby instance
      self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]

      #remember the last line always auto returns. So here we are returning the Ruby instance with the ID value assigned
      self
  end

  def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end

end
