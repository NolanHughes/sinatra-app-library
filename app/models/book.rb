class Book < ActiveRecord::Base
  belongs_to :user

  def self.find_by_level(level_input)
    books = all.collect do |book|
      if book.guided_reading_level == level_input.upcase
        book
      end
    end.compact

    if !books.empty?
      books
    end
  end

  def self.find_by_genre(genre_input)
    books = all.collect do |book|
      if book.genre.downcase == genre_input.downcase
        book
      end
    end.compact

    if !books.empty?
      books
    end
  end

  def slug
    self.title.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Book.all.find do |book|
      if book.slug == slug
        book
      end
    end
  end

end
