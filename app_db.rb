require 'sqlite3'

db = SQLite3::Database.new 'test.sqlite'

db.execute "INSERT INTO Cars (model, price) VALUES ('Jaguar', 30000)"
db.close