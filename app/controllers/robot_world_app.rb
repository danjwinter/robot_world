require 'pony'
require 'rubygems'

class RobotWorldApp < Sinatra::Base

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = RobotWorld.all
    erb :index
  end

  get '/mobilization' do
    erb :mobilization
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    RobotWorld.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |serial_number|
    @robot = RobotWorld.find(serial_number.to_i)
    erb :show
  end

  not_found do
    erb :error
  end

  get '/robots/:id/edit' do |serial_number|
    @robot = RobotWorld.find(serial_number.to_i)
    erb :edit
  end

  put '/robots/:id' do |serial_number|
    RobotWorld.update(serial_number.to_i, params[:robot])
    redirect "/robots/#{serial_number}"
  end

  delete '/robots/:id' do |serial_number|
    RobotWorld.delete(serial_number.to_i)
    redirect '/robots'
  end

end