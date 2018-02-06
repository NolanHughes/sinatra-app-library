class UserController < AppController
include Helpers

  get '/users/login' do
    if session[:user_id]
      redirect to '/users/home'
    else
      erb :'/users/login'
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
      erb :'/users/signup'
    end
  end

  post '/users/signup' do
    if params[:user][:username].empty?#check if username is already taken
      flash[:message] = "*Please enter a valid username"
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
    erb :'/users/home'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/public_library"
  end

  get '/users/logout' do
    session.clear
    flash[:message] = "You have been successfully logged out"
    redirect to "/users/login"
  end

end
