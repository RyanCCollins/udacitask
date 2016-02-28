require_relative 'todolist.rb'

# Creates a new todo list
list = TodoList.new("Todo")
# Add four new items
list.add_new_item("Submit the rest of the Ruby projects", "2016-03-03")
list.add_new_item("Submit project 2-3 of FE", "2016-03-03")
list.add_new_item("Submit Capstone", "2016-03-03")
list.add_new_item("Do other awesome projects", "2016-03-03")
list.load_from_file
# Print the list
list.output!
# Delete the first item
list.remove_item(0)
# Print the list
list.output!
# Delete the second item
list.remove_item(0)
# Print the list
list.output!
# Update the completion status of the first item to complete
list.change_status(0, 'Complete')
# Print the list
list.output!
# Update the title of the list
list.title = "My Todo List"
# Print the list
list.output!
