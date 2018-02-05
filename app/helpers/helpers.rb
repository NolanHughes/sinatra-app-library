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
end
