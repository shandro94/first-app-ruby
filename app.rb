#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pony'
require 'sqlite3'

def get_db
	db = SQLite3::Database.new 'ilyaroom.sqlite'
	db.results_as_hash = true
	return db
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS 
					"Users" (
					"ID" INTEGER PRIMARY KEY AUTOINCREMENT, 
					"Username" TEXT, 
					"Phone" TEXT, 
					"DateStamp" TEXT, 
					"Performer" TEXT
					)'
end

get '/' do
	erb "Hello, <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/something' do
	erb :something
end

get '/about' do
	erb :about
end

get '/appointment' do
	erb :appointment
end

post '/appointment' do
	@username = params[:username]
	@phone = params[:phone]
	@time = params[:time]
	@performer = params[:performer]

	errors = {
		:username => 'Enter your name',
		:phone => 'Enter your phone number',
		:time => 'Enter desirable appoint time',
	}

	@error = errors.select {|key,_| params[key]==""}.values.join("<br>")

	if @error == '' #if not
		db = get_db
		db.execute 'insert into users (username, phone, datestamp, performer) 
		values (?,?,?,?)', [@username,@phone,@time,@performer]
#		File.open './public/users.txt','a' do |file|
#			file.write "Name: #{@username}; Phone: #{@phone}; Time: #{@time}; Performer:#{@performer}\n"
#	end
		@message = 'Запись успешно произведена.'
	end
		erb :appointment
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	
	@nickname = params[:nickname]
	@message = params[:message]

	errors = {
		:nickname => 'Enter your name',
		:message => 'Enter your message',
	}


	@error = errors.select {|key,_| params[key]==""}.values.join("<br>")

	if @error == '' #if not
		Pony.mail({
				:to => 'shandro94@mail.ru', 
				:subject => @nickname + " has contacted you via the Website",
				:body => @message,
			    :via => :smtp,
			    :from => "Site/contacts/#{@nickname} <shandro94@mail.ru>",
			    :via_options => {
			     :address              => 'smtp.mail.ru',
			     :port                 => '587',
			     :enable_starttls_auto => true,
			     :user_name            => 'shandro94@mail.ru',
			     :password             => 'Core2Duo1',
			     :authentication       => :plain, 
			     :domain               => "localhost.localdomain" 
			     }
		    })
		@push_notification = 'The message has hi been sent successfully.'
	end
		
	erb :contacts

end

get '/showusers' do

	db = get_db
	@results = db.execute 'select * from Users order by id desc'

	erb :showusers
end