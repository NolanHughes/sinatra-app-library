[X] User has_many books
      :users have a username, password(password_digest), and email

[X] Book belongs to User
      :books have :title, :author, :guided_reading_level, and :genre

[X] Filtering by level and genre and maybe author

[X] Make edit capabilities
[X] Make delete capabilities
[X] Make logout feature
[X] Make sure people can't access shit they aren't supposed to
[X] Get book by :id
[X] Make homepage button (Done on "/books/show") #Might just put home button on everything with layout
[X] Add html template(s) for duplicate html - layout.erb
[X] Don't delete everything when reloading after an error creating a new book
[X] Check if username is already taken
[X] Check if a valid email address
[X] Check that password is a strong enough
[X] Hide password on log in
[X] Delete user function
[X] Put log out button in nav bar
[X] Style everything so it looks nice
[X] Add first name to sign up page. Use this to greet on home page and public page. List first name (username) in users list
ex. Nolan (Nhughes987)
    Jessie (Jhughes91)
    Jessie (JessicaMarie)
[X] If signup does not work, keep users data
[X] Use slugs for everything
[X] Able to sort by title, author, genre, and level on home page.
[X] Deploy with Heroku
[X] Write in spec file (Still need to write readme and write desc about it in spec)
[] User list is just searchable by username in a search bar in the navbar instead of dropdown
[X] books table has a quantity column
[] Able to input more than one book at a time
[] Email to find password?
[] Change flash messages to layout (Doesn't work with how I want flash messages displayed.)
[X] Put post /users/home in get users/home so page won't be reloaded.
[] Sort function sorts by capital letters then puts lower case after. Thats pretty dumb. Also if user changes sort url to something other than specified strings in names_to_sort_by, error message isn't exactly what I want. (Note in user_controller)
