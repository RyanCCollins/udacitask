Udacitask, Part 1-2

## Getting Started
To run this app properly, you need to get the web server running.

First, run 
```
bundle install
```
in order to install all of the dependencies.  

Note: the app was created using Ruby v. 2.2.1p85.  If you have any issues, trying using rvm with that version. [See here](https://rvm.io/) for more details.

From the commandline, run the following from the root directory 
```
ruby app.rb
```

The terminal will print out the contents of app.rb and then will start the server.  

You will see output that looks like:
```
== Sinatra (v1.4.7) has taken the stage on 1337 for development with backup from Puma
Puma starting in single mode...
* Version 3.0.2 (ruby 2.2.1-p85), codename: Plethora of Penguin Pinatas
* Min threads: 0, max threads: 16
* Environment: development
* Listening on tcp://0.0.0.0:1337
```

The webpage can be accessed from [http://localhost:1337](http://localhost:1337) at this point.

## About
Built a commandline and Sinatra based web application using Object Oriented Ruby that keeps track of your tasks and helps you to stay organized.  The app parses and reads JSON data and converts it into native Ruby Data structures.  It uses classic Object Oriented Programming in order to intelligently manipulate the data.

The app utilizes modules and both existing and custom Ruby Gems in order to extend the capabilities.

If you’re familiar with microblogging sites, you’ll know that they usually allow you to define different types of posts like “text”, “quote”, “image”, or  “link”. All of the posts are then listed in one big stream, with different formatting depending on the type of post.

