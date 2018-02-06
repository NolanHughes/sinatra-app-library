class BookController < AppController
  include Helpers

  get '/books/new' do
    if logged_in?
      erb :'books/new'
    else
      flash[:message] = "*You must be logged in to do that!"
      redirect to '/users/login'
    end
  end

  post '/books/new' do #don't delete everything when reloading after an error
    if params[:book][:title].empty?
      flash[:message] = "*Please enter a valid title"
      redirect to '/books/new'
    elsif params[:book][:author].empty?
      flash[:message] = "*Please enter a valid author"
      redirect to '/books/new'
    elsif params[:book][:guided_reading_level].size != 1 || !letters?(params[:book][:guided_reading_level])
      flash[:message] = "*Please enter a valid Guided Reading Level. It is a single letter from A-Z"
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

  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    erb :'books/show'
  end

  get '/books/:id/edit' do #make this a slug later
    @book = Book.find_by_id(params[:id])
    erb :'books/edit'
  end

  patch '/books/:id' do
    @book = Book.find_by_id(params[:id])
    @book.title = params[:book][:title]
    @book.save
    erb :'/books/show'
  end

  delete '/books/:id/delete' do
    book = Book.find_by_id(params[:id])
    book.delete
    redirect to '/users/show'
  end

end
