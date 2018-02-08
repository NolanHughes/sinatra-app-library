module Helpers
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

  def letters?(string)
    string.chars.any? { |char| ('a'..'z').include? char.downcase }
  end

  def valid_email?(email)
    email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/) ? true : false
  end

  def password_has_upper_and_lower_case?(password)
    password.count("a-z") > 0 && password.count("A-Z")
  end

  def valid_password?(password)
    if password.size >= 8 && password =~ /\d/ && password_has_upper_and_lower_case?(password) >= 1
      true
    else
      false
    end
  end

end
