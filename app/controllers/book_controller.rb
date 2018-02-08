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

    post '/books' do #don't delete everything when reloading after an error
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
        book.user = current_user
        book.save
        
        redirect to '/users/home'
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
      if logged_in?
        erb :'books/error'
      else
        redirect to '/users/login'
      end
    end

    get '/books/:id' do #slug it up!
      if logged_in? && @book = current_user.books.find_by_id(params[:id])
        erb :'books/show'
      else
        flash[:message] = "*That book does not appear to be in your library. You must be logged in as that user to view that book."
        redirect to '/users/home'
      end
    end

    get '/books/:id/edit' do #make this a slug later
      if logged_in?
        @book = Book.find_by_id(params[:id])

        if current_user.books.include?(@book)
          erb :'books/edit'
        else
          flash[:message] = "*You need to be logged into the proper account to edit this book"
          redirect to "/users/home"
        end
      else
        flash[:message] = "*You can't edit a book if you aren't logged in"
        redirect to '/users/home'
      end
    end

    patch '/books/:id' do #slug it up!
      @book = Book.find_by_id(params[:id])
      if params[:book][:title].empty?
        flash[:message] = "*Please enter a valid title"
        redirect to "/books/#{@book.id}/edit"
      elsif params[:book][:author].empty?
        flash[:message] = "*Please enter a valid author"
        redirect to "/books/#{@book.id}/edit"
      elsif params[:book][:guided_reading_level].size != 1 || !letters?(params[:book][:guided_reading_level])
        flash[:message] = "*Please enter a valid Guided Reading Level. It is a single letter from A-Z"
        redirect to "/books/#{@book.id}/edit"
      else
        @book.title = params[:book][:title]
        @book.author = params[:book][:author]
        @book.genre = params[:book][:genre]
        @book.guided_reading_level = params[:book][:guided_reading_level]
        @book.save

        erb :'/books/show'
      end
    end

    delete '/books/:id/delete' do
      binding.pry
      book = Book.find_by_id(params[:id])

      if current_user.books.include?(book)
        book.delete
        redirect to '/users/home'
      else
        flash[:message] = "*You need to be logged into the proper account to delete this book"
        redirect to "/users/home"
      end
    end

end
