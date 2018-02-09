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
      erb :'/users/login', :layout => :home_layout
    end
  end

  get '/users/signup' do
    if session[:user_id]
      redirect to "/users/home"
    else
      erb :'/users/signup', :layout => :home_layout
    end
  end

  post '/users/signup' do #maybe leave data that was filled out in this route too
    if params[:user][:username].empty?
      flash[:message] = "*Username cannot be blank"
      erb :'/users/signup', :layout => :home_layout
    elsif User.all.find { |user| user.username == params[:user][:username] }
      flash[:message] = "*Username is already taken"
      erb :'/users/signup', :layout => :home_layout
    elsif params[:user][:first_name].empty?
      flash[:message] = "*First Name cannot be blank"
      erb :'/users/signup', :layout => :home_layout
    elsif !valid_email?(params[:user][:email])
      flash[:message] = "*Please enter a valid email"
      erb :'/users/signup', :layout => :home_layout
    elsif !valid_password?(params[:user][:password])
      flash[:message] = "*Please enter a valid password"
      erb :'/users/signup', :layout => :home_layout
    else
      user = User.create(username: params[:user][:username], first_name: params[:user][:first_name].capitalize, email: params[:user][:email], password: params[:user][:password])
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
      redirect to "/users/login"
    else
      flash[:message] = "*You must be logged in to log out"
      erb :"/users/login", :layout => :home_layout
    end

  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/public_library"
  end

  get '/users/:slug/delete' do
    erb :'users/delete'
  end

  delete '/users/:slug/delete' do
    @user = User.find_by_slug(params[:slug])

    if @user && @user.authenticate(params[:user][:password])
      session.clear
      @user.delete

      redirect to '/users/signup'
    else
      flash[:message] = "*The password you entered was not correct. Please re-enter it to delete your profile."
      erb :'/users/delete'
    end

  end

end
