require './config/environment'
require 'rack-flash'

class AppController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :'index', :layout => :home_layout
  end

end
