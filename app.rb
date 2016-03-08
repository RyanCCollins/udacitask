# require 'chronic'
# require 'colorize'
# Find a third gem of your choice and add it to your project
require 'date'
require_relative "lib/listable"
require_relative "lib/errors"
require_relative "lib/udacilist"
require_relative "lib/todo"
require_relative "lib/event"
require_relative "lib/link"
# myapp.rb


list = UdaciList.new(title: "Julia's Stuff")
list.add("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
list.add("todo", "Sweep floors", due: "2016-01-30")
list.add("todo", "Buy groceries", priority: "high")
list.add("event", "Birthday Party", start_date: "2016-05-08")
list.add("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
list.add("link", "https://github.com", site_name: "GitHub Homepage")
list.all
list.delete(3)
list.all


# SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
# --------------------------------------------------
new_list = UdaciList.new # Should create a list called "Untitled List"
new_list.add("todo", "Buy more dog food", due: "in 5 weeks", priority: "medium")
new_list.add("todo", "Go dancing", due: "in 2 hours")
new_list.add("todo", "Buy groceries", priority: "high")
new_list.add("event", "Birthday Party", start_date: "May 31")
new_list.add("event", "Vacation", start_date: "Dec 20", end_date: "Dec 30")
new_list.add("event", "Life happens")
new_list.add("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
new_list.add("link", "http://ruby-doc.org")

# SHOULD RETURN ERROR MESSAGES
# ----------------------------
#new_list.add("image", "http://ruby-doc.org") # Throws InvalidItemType error
#new_list.delete(9) # Throws an IndexExceedsListSize error
#new_list.add("todo", "Hack some portals", priority: "super high") # throws an InvalidPriorityValue error

# DISPLAY UNTITLED LIST
# ---------------------
new_list.all

# DEMO FILTER BY ITEM TYPE
# ------------------------
new_list.filter("event")

# For fun, we are playing with sinatra
# When you start the app, load up sinatra
# And load the index template
require 'sinatra'

class WebApp < Sinatra::Base

  configure do # Run config to run the app at localhost:80
    set :bind, '0.0.0.0'
    set :port, 1337
    set :method_override, true
  end

  # Get / and load the index template
  get '/'  do
    @list_items = UdaciList.all_todo_items
    @title = "Udacitask 2.0!"
    erb :index
  end

  # Post a new list item to todo lists
  post '/' do
    list = UdaciList.new
    item = params["item"]
    due_date = Date.strptime(params["due_date"])
    priority = params["priority"]
    list.add("todo", item, due: due_date, priority: priority)
    redirect '/'
  end

  # Get a list item by id and show the edit template
  get '/:id' do
    @id = params["id"].to_i
    @item = UdaciList.get_one @id
    @title = "Edit item ##{@id}"
    erb :edit
  end

  # Get method for delete by id
  get '/:id/delete' do
    @id = params["id"].to_i
    @item = UdaciList.get_one @id
    @title = "Confirm deletion of note ##{@id}"
    erb :delete
  end

  get '/:id/complete' do
    @id = params["id"].to_i
    @item = UdaciList.get_one @id

    # Reverse the completion status
    @item.complete = !@item.complete
  end

  # Put method for updating an item
  put '/:id' do
    @id = params["id"].to_i
    @item = UdaciList.get_one @id
    @item.description = params["description"]
    @item.complete = params["complete"]
    redirect '/'
  end

  # Delete item by ID
  delete '/:id' do
    @id = params["id"].to_i
    UdaciList.delete @id
    redirect '/'
  end

end

WebApp.run! # Fairly self explanatory!
