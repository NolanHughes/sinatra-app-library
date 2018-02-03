require './config/environment'
require 'rack-flash'

class AppController < Sinatra::Base
  get '/' do
    "Hello World"
  end
end
