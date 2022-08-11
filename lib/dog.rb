class Dog
    attr_accessor :name, :breed, :id
    def initialize( name:, breed:, id: nil)
        @id = id
        @name = name
        @breed = breed 
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS dogs (
            id INTEGER PRIMARY KEY,
            name TEXT,
            breed TEXT
        )
        SQL
        DB[:conn].execute(sql)
    end

    def self.drop_table
        sql = <<-SQL
        DROP TABLE dogs
        SQL
        DB[:conn].execute(sql)
    end

    def save
        sql = <<-SQL
            INSERT INTO dogs (name, breed)
            VALUES(?, ?)
        SQL
        DB[:conn].execute(sql, self.name, self.breed)
    end

    def self.create(name, breed)
       dog = Dog.new(name, breed)
       self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
       dog.save
    end
end
