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
	@username = params[:username]
	@phone = params[:phone]
	@time = params[:time]
	@performer = params[:performer]

	if @username == ''
		@error = 'Enter your name.'
	elsif @phone == ''
		@error = 'Enter your phone.'
	elsif @time == ''
		@error = 'Enter derirable time.'
	else
		File.open './public/users.txt','a' do |file|
			file.write "Name: #{@username}; Phone: #{@phone}; Time: #{@time}; Performer:#{@performer}\n"
		end
		@message = 'Запись успешно произведена.'
	end
		erb :appointment
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@message = "Button was pressed."
	erb :contacts
end