# Blog Application



## Features

- Create,Edit, Delete, List and Show Posts
- Create, Edit, Delete, List Comments
- Create, Delete Reactions
- Action Cable: Comments and Reactions and Post changes on post comments list page(only)



## Tech
- ruby 3.1.1
- Ruby on Rails 7.0.2.3
- MySQL 8.0.28
- yarn 1.22.5
- node v17.7.2
- redis 5.0.7

## Setup for DEV
Once everything from tech list is available clone the project. 
```sh
git clone https://github.com/bosniadev/blog.git
cd blog
bundle install
yarn install
```
For database in project directory export env variables example.
```sh
export MYSQL_USERNAME=root
export MYSQL_PASSWORD=password
export MYSQL_HOST=localhost
 ```
 When running the first time from project directory run.
 ```sh
bundle exec rails db:create
bundle exec rails db:migrate
 ```
And finally to start dev mode.
 ```sh
./bin/dev
 ```
Visit http://localhost:3000 to access the application.

## Useful links
Database Schema:  
https://dbdiagram.io/d/625c58c72514c9790344a8f0  
Heroku app running this code(but using postgreSQL):  
https://blog-99.herokuapp.com/

## Limitations
- Styling for this project is non-existent basic bootstrap buttons and inputs.
- Models, Helpers, and example feature specs are written but missing a lot of specs.
- A lot of not needed files form rails generator cleaning up is needed.
- Basic things like pagination missing not needed to meet the requirements but in real scenarios must have.
- Only logged in users can leave comments and reactions  and create posts.
- User that creates a record is the only user that can edit or delete the record(Post, Comment, Reaction).
- Posts, Comments and Reactions are visible without need to log in.
- Action Cable: if user is on the post comments page he is automatically subscribed to post channel so while on that page any change to post comment or a reaction seen on that page will be updated.



