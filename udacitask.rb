require_relative 'todolist.rb'

# Creates a new todo list
list = TodoList.new("Todo")
# Add four new items
list.add_new_item("Get a job", "2016-03-03")
list.add_new_item("Do the dishes", "2015-03-20")
list.add_new_item("Submit this project", "2015-02-28")
list.add_new_item("Do other awesome projects", "2016-03-03")
list.load_from_file
# Print the list

list.output!
# Delete the first item
puts ">>> Removing item 1..."
list.remove_item(0)
# Print the list
sleep(2)
list.output!
# Delete the second item
puts ">>> Removing item 2..."
list.remove_item(0)
# Print the list
sleep(2)
list.output!
# Update the completion status of the first item to complete
sleep(0.5)
puts ">>> Marking item 1 complete..."
list.change_status(0, 'Complete')
# Print the list
sleep(2)
list.output!
# Update the title of the list
sleep(0.5)
puts ">>> Updating title..."
list.title = "My New Todo List"
# Print the list
sleep(2)
list.output!
