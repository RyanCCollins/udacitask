require_relative 'todolist.rb'

# Creates a new todo list
list = TodoList.new("Todo")

# Realistically, I would check for a new ID before adding to the list
    # Since database is coming up soon, I will wait til then.
    # Comment / uncomment this to test it out.
list.load_from_file

# Add four new items
list.add_new_item("Get a job", "2016-03-03")
list.add_new_item("Do the dishes", "2015-03-20")
list.add_new_item("Submit this project", "2015-02-27")
list.add_new_item("Do other awesome projects", "2016-03-03")

# Print the list
list.print
# Delete the first item
puts ">>> Removing item 1..."
list.remove_item(0)
# Print the list
sleep(2)
list.print
# Delete the second item
puts ">>> Removing item 1..."
list.remove_item(0)
# Print the list
sleep(2)
list.print
# Update the completion status of the first item to complete
sleep(0.5)
puts ">>> Marking item 1 complete..."
list.change_status(0, true)
# Print the list
sleep(2)
list.print
# Update the title of the list
sleep(0.5)
puts ">>> Updating title..."
list.title = "My New Todo List"
# Print the list
sleep(2)
list.print

# Save the new list to file and simulate a delay
list.output_to_file!
puts ">>> Outputting to file..."
sleep(1)
puts ">>> File Saved! Hooray!  Have a nice day :)..."
sleep(1)