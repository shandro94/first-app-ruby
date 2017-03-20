#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
	erb "Hello, <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/appointment' do
	erb :appointment
end

post '/appointment' do
	@name = params[:username]
	@phone = params[:phone]
	@time = params[:time]
	@performer = params[:performer]

	lines = []
	File.open './public/users.txt','a' do |file|
		file.write "Name: #{@name}; Phone: #{@phone}; Time: #{@time}; Performer:#{@performer}\n"
	end

	@message = 'Запись успешно произведена.'

	erb :appointment

end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@message = "Button was pressed."
	erb :contacts
end