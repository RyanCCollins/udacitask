require_relative 'todolist.rb'

# Creates a new todo list
list = TodoList.new("Todo")
# Add four new items
list.add_new_item("Finish iOS Capstone")
list.add_new_item("Get a job")
list.add_new_item("Finish Front End ND")
list.add_new_item("Finish Ruby / Rails Track")
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
list.generate_json