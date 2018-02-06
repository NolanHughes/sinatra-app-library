class UserController < AppController
include Helpers

  get '/users/login' do
    erb :'/users/login'
  end

  post '/users/login' do
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect to '/users/show'
    else
      flash[:message] = "*Please enter a valid username and password"
      erb :'/users/login'
    end
  end

  get '/users/signup' do
    erb :'/users/signup'
  end

  post '/users/signup' do
    if params[:user][:username].empty?#check if username is already taken
      flash[:message] = "*Please enter a valid username"
      redirect to '/signup'
    elsif params[:user][:email].empty?#check if a valid email address
      flash[:message] = "*Please enter a valid email"
      redirect to '/signup'
    elsif params[:user][:password].empty?#check that it is a strong enough password
      flash[:message] = "*Please enter a valid password"
      redirect to '/signup'
    else
      @user = User.create(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])
      session[:user_id] = @user.id
      erb :'/users/show'
    end
  end

  get '/users/show' do
    erb :'/users/show'
  end

  get '/users/logout' do
    session.clear
    flash[:message] = "You have been successfully logged out"
    redirect to "/users/login"
  end

end
