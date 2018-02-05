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
end
