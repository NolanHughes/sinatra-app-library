class UserController < AppController
include Helpers

  get '/users/login' do
    if session[:user_id]
      redirect to '/users/home'
    else
      erb :'/users/login', :layout => :home_layout
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect to '/users/home'
    else
      flash[:message] = "*Please enter a valid username and password"
      erb :'/users/login'
    end
  end

  get '/users/signup' do
    if session[:user_id]
      redirect to "/users/home"
    else
      erb :'/users/signup', :layout => :home_layout
    end
  end

  post '/users/signup' do
    binding.pry
    if params[:user][:username].empty?#check if username is already taken
      flash[:message] = "*Username cannot be blank"
      erb :'/users/signup'
    elsif User.all.find { |user| user.username == params[:user][:username] }
      flash[:message] = "*Username is already taken"
      erb :'/users/signup'
    elsif params[:user][:email].empty?#check if a valid email address
      flash[:message] = "*Please enter a valid email"
      erb :'/users/signup'
    elsif params[:user][:password].empty?#check that it is a strong enough password
      flash[:message] = "*Please enter a valid password"
      erb :'/users/signup'
    else
      user = User.create(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
      session[:user_id] = user.id
      redirect to '/users/home'
    end
  end

  get '/users/home' do
    if logged_in?
      erb :'/users/home'
    else
      flash[:message] = "*You must be logged in to do that!"
      redirect to "users/login"
    end
  end

  get '/users/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You have been successfully logged out"
    end
    erb :"/users/login"
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/public_library"
  end

end
