require './config/environment'
require 'rack-flash'

class AppController < Sinatra::Base
  use Rack::Flash

  configure do
    # set :public_folder, 'public'#Not sure what this does. Maybe has to do with public folder for css, js, etc.
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index'
  end
  
end
