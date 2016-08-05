require 'sinatra/base'

class Myapp < Sinatra::Base
  get '/' do
    erb :index
  end
end
