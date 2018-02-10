source 'http://rubygems.org'

ruby '2.3.5'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem "tux"

group :development do
   gem 'sqlite3'
end

group :production do
   gem 'pg', '~> 0.18.4'
   gem 'activerecord-postgresql-adapter'
end
