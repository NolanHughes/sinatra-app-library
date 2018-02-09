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

    post '/books' do
      @title = params[:book][:title]
      @author = params[:book][:author]
      @genre = params[:book][:genre]
      @level = params[:book][:guided_reading_level]

      if params[:book][:title].empty?
        flash[:message] = "*Please enter a valid title"
        erb :'/books/new'
      elsif current_user.books.detect { |book| book.title.downcase == @title.downcase }
        flash[:message] = "*That title is already in your library"
        erb :'/books/new'
      elsif params[:book][:author].empty?
        flash[:message] = "*Please enter a valid author"
        erb :'/books/new'
      elsif params[:book][:guided_reading_level].size != 1 || !letters?(params[:book][:guided_reading_level])
        flash[:message] = "*Please enter a valid Guided Reading Level. It is a single letter from A-Z"
        erb :'/books/new'
      else
        book = Book.create(title: params[:book][:title], author: params[:book][:author], genre: params[:book][:genre].capitalize, guided_reading_level: params[:book][:guided_reading_level].capitalize)
        book.user = current_user
        book.save

        redirect to '/users/home'
      end
    end

    get '/books/filter_by_genre' do
      if logged_in?
        erb :'books/filter_by_genre'
      else
        flash[:message] = "*You must be logged in to do that!"
        redirect to '/users/login'
      end
    end

    get '/books/filter_by_level' do
      if logged_in?
        flash[:message] = nil
        erb :'books/filter_by_level'
      else
        flash[:message] = "*You must be logged in to do that!"
        redirect to '/users/login'
      end
    end

    post '/books/filter/genre' do
      if @books_by_genre = current_user.books.find_by_genre(params[:genre])
        erb :'/books/show_by_genre'
      else
        flash[:message] = "*You don't have any books in your library with that level/genre"
        redirect to '/books/error'
      end
    end

    post '/books/filter/level' do
      if @books_by_level = current_user.books.find_by_level(params[:level])
        erb :'/books/show_by_level'
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

    get '/books/:slug' do
      if logged_in? && @book = current_user.books.find_by_slug(params[:slug])
        erb :'books/show'
      else
        flash[:message] = "*That book does not appear to be in your library. You must be logged in as that user to view that book."
        redirect to '/users/home'
      end
    end

    get '/books/:slug/edit' do
      if logged_in?
        @book = current_user.books.find_by_slug(params[:slug])
        @title = @book.title
        @author = @book.author
        @genre = @book.genre
        @level = @book.guided_reading_level

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

    patch '/books/:id' do
      @book = Book.find_by_id(params[:id])
      @title = params[:book][:title]
      @author = params[:book][:author]
      @genre = params[:book][:genre]
      @level = params[:book][:guided_reading_level]
      # binding.pry
      if params[:book][:title].empty?
        flash[:message] = "*Please enter a valid title"
        erb :"/books/edit"
      elsif current_user.books.detect { |book| book.title.downcase == @title.downcase && book.id != @book.id }
        flash[:message] = "*That title is already in your library"
        erb :'/books/edit'
      elsif params[:book][:author].empty?
        flash[:message] = "*Please enter a valid author"
        erb :"/books/edit"
      elsif params[:book][:guided_reading_level].size != 1 || !letters?(params[:book][:guided_reading_level])
        flash[:message] = "*Please enter a valid Guided Reading Level. It is a single letter from A-Z"
        erb :'/books/edit'
      else
        @book.title = params[:book][:title]
        @book.author = params[:book][:author]
        @book.genre = params[:book][:genre]
        @book.guided_reading_level = params[:book][:guided_reading_level]
        @book.save

        erb :'/books/show'
      end
    end

    delete '/books/:slug/delete' do
      book = current_user.books.find_by_slug(params[:slug])

      if current_user.books.include?(book)
        book.delete
        flash[:message] = "*Your book has been successfully deleted"
        redirect to '/users/home'
      else
        flash[:message] = "*You need to be logged into the proper account to delete this book"
        redirect to "/users/home"
      end
    end

end
