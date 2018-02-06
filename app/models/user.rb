class User < ActiveRecord::Base
  has_secure_password
  has_many :books

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
