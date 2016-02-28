require 'date' # We have to load the date class to compare dates for due date
require 'json'

class TodoList
  attr_accessor :title
  attr_reader :items

  def initialize(list_title)
    # Initialize our instance variables
    @title = list_title
    @items = Array.new
    # Will name the file with the todos.json title
    @file = "todo.json"
  end

  # Push a new item onto the items array
  def add_new_item(new_item, due_date)
    item = Item.new(new_item, due_date)
    @items << item
  end

  # Parse JSON from the Todo.json file
  def load_from_file
    # Protects against the file being empty or nonexistant
    if File.zero?(@file) || File.exists?(@file) == false
      return
    end
    file = File.read(@file)

    # Get the parsed JSON from the file and protect against a nil object
    item_array = get_parsed_json
    unless item_array == nil
      item_array.each do |item|
        date = item["due_date"]
        item = Item.new(item["description"], date, item["completed"])
        @items << item
      end
    end
  end

  # Return the parsed JSON, or nothing if there is an exception
    # We could set some kind of debug mode if there is a parsing error,
    # But for now, I am leaving it be.  It will just return nil, no error even though
    # Rescue could be called from a parsing error.
  def get_parsed_json
    file = File.read(@file)
    return JSON.parse(file)
  rescue JSON::ParserError => e
    return nil
  end

  # Create a JSON Hash from each item
  def items_to_json
    array = Array.new
    @items.each do |item|
      array << item.hash_me
    end
    return array.to_json
  end

  # Output to the file in JSON format
  def output_to_file!
    File.new(@file, 'w+')
    File.open(@file, 'w') do |file|
      file.write(items_to_json)
    end
  end

  # Delete an item at a specific index
  def remove_item(index)
    @items.delete_at(index)
  end

  # Takes an index and a status (bool)
    # and updates the status.
  def change_status(index, status)
    @items[index].update_status!(status)
  end

  #Convenience for printing via the compiled output
  def print
    puts compile_output
  end

  # Compile output for the terminal
    # It is really not clear from the specs which class this should occur in?
  def compile_output
    output = ""
    output << @title
    output << "\n---------\n"
    @items.each_with_index do |item, index|
      output << "#{index + 1} - #{item.print_item}\n"
    end
    return output # I know that we don't need to call output, but I think it makes the intention clear
  end
end

class Item
  attr_reader :description, :due_date
  attr_accessor :completed # Same as completion_status from the specs, but as a Bool.

  # Initialize with variables.  Due_date MUST be a string.
    # Normall
  def initialize(item_description, due_date = Date.now, completed = false)
    @description = item_description
    @completed = completed
    @due_date = due_date.as_date
  end

  def update_status!(complete)
    @completed = complete
  end

  def hash_me # Similiar to the common coloquial beer me, the hash me gives you a hash
    item_hash = { :description => @description, :completed => @completed, :due_date => @due_date }
    return item_hash
  end

  # It's not totally clear what class should print items
    # This return output for an item and the TodoList prints it
  def print_item
    output = "#{@description}\n"
    output << "Status: #{is_complete? ? "Complete" : "Not Complete"}\n"
    output << "Due Date: #{@due_date.as_string}\n"
    output << "Overdue: #{is_overdue? ? "Yes" : "No"}\n"
    return output
  end

  # Normally, I would not see the point of a boolean
    # method like this, but it's a requirement.
  def is_complete?
    return self.completed
  end

  # Returns whether the item is overdue based on due_date and date today
    # We would probably want to get more specific for this with a DateTime.
  def is_overdue?
    now = Date.today
    return @due_date < now
  end
end

#This is probably not a good idea.
  # It is not actually mutating, but just handling the translation
  # From dates to string.  I need to learn more about type safety in Ruby and
  # Would love to hear some strategies you use for error handling.
class Date
  def as_string
    return self.strftime("%Y-%m-%d")
  end
end

class String
  def as_date
    return Date.strptime(self, "%Y-%m-%d")
  end
end
