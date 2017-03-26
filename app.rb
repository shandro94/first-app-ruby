#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pony'


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

	errors = {
		:username => 'Enter your name',
		:phone => 'Enter your phone number',
		:time => 'Enter desirable appoint time',
	}

	@error = errors.select {|key,_| params[key]==""}.values.join("<br>")
	#errors.each do |key,err| 
	#	if params[key] == ''
	#		@error = errors[key]
	#	end
	#end

	if @error == '' #if not
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
	
	@push_notification = "The message has been successfully sent."
	@nickname = params[:nickname]
	@message = params[:message]

	errors = {
		:nickname => 'Enter your name',
		:message => 'Enter your message',
	}

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
#	     :user_name            => 'ilya.lubit.tanyu@gmail.com',
#	     :password             => 'Core2duo1',
	     :user_name            => 'shandro94@mail.ru',
	     :password             => 'Core2Duo1',
	     :authentication       => :plain, 
	     :domain               => "localhost.localdomain" 
	     }
    })


	erb :contacts


end