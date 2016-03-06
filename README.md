Udacitask, Part 1-2

## Getting Started
To run this app properly, you are going to want to do things a bit differently to get the Webrick server going.

First, run 
```
bundle install
```
in order to install all of the dependencies.  Note: the app was created using Ruby v. 2.2.1p85.  If you have any issues, trying using rvm with that version. [See here](https://rvm.io/) for more details.

From the commandline, run the following from the root directory 
```
ruby app.rb
```

## About
Built a commandline and Sinatra based web application using Object Oriented Ruby that keeps track of your tasks and helps you to stay organized.  The app parses and reads JSON data and converts it into native Ruby Data structures.  It uses classic Object Oriented Programming in order to intelligently manipulate the data.

The app utilizes modules and both existing and custom Ruby Gems in order to extend the capabilities.

If you’re familiar with microblogging sites, you’ll know that they usually allow you to define different types of posts like “text”, “quote”, “image”, or  “link”. All of the posts are then listed in one big stream, with different formatting depending on the type of post.

