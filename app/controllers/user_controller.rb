class UserController < AppController
  get '/users/login' do
    erb :'/users/login'
  end

  get '/users/signup' do
    erb :'/users/signup'
  end

  post '/users/login' do
    # binding.pry
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
    binding.pry
  end

  get '/users/show' do
    #make current user method
    erb :'/users/show'
  end
end
