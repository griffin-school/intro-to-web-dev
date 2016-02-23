# Add Users to your app.
To me, one of the main differences between a webpage and a web application is the ability to sign in. 
We will be adding users to our existing Railsguides app. 

User systems aren't too complex, but I don't want to use our time to learn them. There are basic tutorials
on [codecademy](https://www.codecademy.com/learn/rails-auth) and other places online so feel free to learn it on your own.

We are going to be plugging in an existing Auth system into our rails apps called [Devise](https://github.com/plataformatec/devise)

## Steps to add Users to your Railsguides application
### Install Devise
* Go to https://github.com/plataformatec/devise
* Follow the instructions to install Devise in your rails app

### Add user relation to the Articles model
![Article Model](./article-model.png?raw=true "Optional Title")

### Add article relation to user
![User Model](./user-model.png?raw=true "Optional Title")

### Create a database migration to add the new fields to User and Article
```
$ bin/rails generate migration AddUserToArticles 
```
![Migration](./migration.png?raw=true "Optional Title")

### Edit ApplicationController to require login
![Application Controller](./application-controller.png?raw=true "Optional Title")

### Edit the ArticleController to retreive articles for User
![Article Controller](./article-controller.png?raw=true "Optional Title")
