User has_many books
:users have a username, password(password_digest), and email

Book belongs to User
:books have :title, :author, :guided_reading_level, and :genre

For views/user/show
<!-- <ol>
  <% current_user.books.each do |book| %>
  <li>Title: <%= book.title %></li>
  <li>Author: <%= book.author %></li>
  <li>Genre: <%= book.genre %></li>
  <li>Level: <%= book.guided_reading_level %></li>
  <% end %>
</ol> -->

Sorting by level and genre and maybe author
