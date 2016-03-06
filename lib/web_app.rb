require 'sinatra'

class WebApp < Sinatra::Base
  get '/'  do
      "Hello and welcome to udacitask 2.0 - Web Version"
  end

  get '/list' do

  end
end
