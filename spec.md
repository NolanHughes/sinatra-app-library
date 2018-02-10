# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app #Using Sinatra::Base in my app_controller
- [x] Use ActiveRecord for storing information in a database #Using ActiveRecord for all of my tables
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) #I have a book and user model
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts) #Users has many books.
- [x] Include user accounts #Users can log in and out
- [x] Ensure that users can't modify content created by other users #Using #logged_in? and #current_user with if statements in my controllers.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying #Enabled routes that let me create a new book, look at and individual book's page, edit, and delete the book.
- [x] Include user input validations #These are everywhere. From signing up and logging in to editing and creating a book to deleting a user profile.
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new) #Using tons of flash messages depending on the situation.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code #My readme file has all of the requirements.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
