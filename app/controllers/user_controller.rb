class UserController < AppController
include Helpers

  get '/users/login' do
    if session[:user_id]
      redirect to '/users/index'
    else
      erb :'/users/login', :layout => :home_layout
    end
  end

  post '/users/login' do
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect to '/users/index'
    else
      flash[:message] = "*Please enter a valid username and password"
      erb :'/users/login', :layout => :home_layout
    end
  end

  get '/users/signup' do
    if session[:user_id]
      redirect to "/users/index"
    else
      erb :'/users/signup', :layout => :home_layout
    end
  end

  post '/users/signup' do
    @username =  params[:user][:username]
    @first_name = params[:user][:first_name]
    @email = params[:user][:email]
    @password = params[:user][:password]

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
      redirect to '/users/index'
    end
  end

  get '/users/index' do
    if logged_in?
      @names_to_sort_by = ["Level", "Author", "Title", "Genre"]
      @books = current_user.books
      @sorted_books = @books.order(guided_reading_level: :asc, title: :asc)

      flash[:message] = "Guided Reading Level"

      erb :'/users/index'
    else
      flash[:message] = "*You must be logged in to do that!"
      redirect to "users/login"
    end
  end

  post '/users/index' do
    @names_to_sort_by = ["Level", "Author", "Title", "Genre"]
    @books = current_user.books

    if params[:sort_name] == "Title"
      @sorted_books = @books.order(title: :asc)
      flash[:message] = "Title"
      erb :'/users/index'
    elsif params[:sort_name] == "Author"
      @sorted_books = @books.order(author: :asc, title: :asc)
      flash[:message] = "Author"
      erb :'/users/index'
    elsif params[:sort_name] == "Genre"
      @sorted_books = @books.order(genre: :asc, title: :asc)
      flash[:message] = "Genre"
      erb :'/users/index'
    else
      @sorted_books = @books.order(guided_reading_level: :asc, title: :asc)
      flash[:message] = "Guided Reading Level"
      erb :'/users/index'
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
    if logged_in?
      flash[:message] = nil
      erb :'users/delete'
    else
      flash[:message] = "*You must be logged in to delete your profile"
      erb :"/users/login", :layout => :home_layout
    end
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
