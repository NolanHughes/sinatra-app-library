class UserController < AppController

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

  get '/books/new' do
    erb :'books/new'
  end

  post '/books/new' do
    if params[:book][:title].empty?
      flash[:message] = "*Please enter a valid title"
      redirect to '/books/new'
    elsif params[:book][:author].empty?
      flash[:message] = "*Please enter a valid author"
      redirect to '/books/new'
    else
      book = Book.create(title: params[:book][:title], author: params[:book][:author], genre: params[:book][:genre].capitalize, guided_reading_level: params[:book][:guided_reading_level].capitalize)
      session[:book_id] = book.id
      book.user = current_user
      book.save
      redirect to '/users/show'
    end
  end

  post '/books/sort' do
    @books_by_level = current_user.books.find_by_level(params[:level])
    @books_by_genre = current_user.books.find_by_genre(params[:genre])

    if @books_by_level
      erb :'/books/sort_by_level'
    elsif @books_by_genre
      erb :'/books/sort_by_genre'
    else
      flash[:message] = "*You don't have any books in your library with that level/genre"
      redirect to '/books/error'
    end
  end

  get '/books/error' do
    erb :'books/error'
  end

  get '/books/:id/edit' do #make this a slug later
    @book = Book.find_by_id(params[:id])
    erb :'books/edit'
  end

  patch '/books/:id' do
    #binding.pry
    book = Book.find_by
  end

  helpers do #how do I make this work in a seperate class
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
