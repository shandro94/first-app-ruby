require 'sqlite3'

db = SQLite3::Database.new 'test.sqlite'

db.execute "select * from Cars" do |car|
	print car
	print "\n"
end