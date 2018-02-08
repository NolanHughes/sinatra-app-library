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
    self.username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      if user.slug.include?(slug)
        User.find_by(username: user.username)
      end
    end
  end

end
