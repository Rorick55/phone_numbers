require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"
require_relative 'methods'

require_relative 'models/contact'



get '/' do
  @page_number = params[:page] || 1
  @return_page = return_page(@page_number)
  offset = (@page_number.to_i - 1) * 3
  @contacts = Contact.limit(3).offset(offset)
  @page_number = @page_number.to_i + 1
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.where("id = #{params[:id]}")
  erb :show
end

get '/search' do
  @contacts = Contact.where(["last_name ILIKE ? OR first_name ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%"])
  erb :search
end

get '/add_contact' do

  erb :add
end

post '/add' do
    first_name = params[:first].downcase
    last_name = params[:last].downcase
    number = params[:number]

    Contact.create({:first_name => first_name.capitalize, :last_name => last_name.capitalize, :phone_number => number})
    redirect '/'

end


