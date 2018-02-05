class BookController < AppController
  include Helpers

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
      # binding.pry
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

end
