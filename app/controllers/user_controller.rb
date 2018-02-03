class UserController < AppController
  get '/users/login' do
    erb :'/users/login'
  end

  get '/users/signup' do
    erb :'/users/signup'
  end

  post '/users/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/users/show'
    else
      flash[:message] = "*Please enter a valid username and password"
      erb :'/users/login'
    end
  end

  post '/users/signup' do
    redirect to '/users/show'
  end

  get '/users/show' do
    #make current user and session methods
    erb :'/users/show'
  end
end
