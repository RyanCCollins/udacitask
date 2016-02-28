require 'date' # We have to load the date class to compare dates for due date
require 'json'

class TodoList
  attr_accessor :title
  attr_reader :items

  def initialize(list_title)
    # Initialize our instance variables
    @title = list_title
    @items = Array.new
    # Will name the file with the Todos.json title
    @file = "todo.json"
  end

  # Push a new item onto the items array
  def add_new_item(new_item, due_date)
    item = Item.new(new_item, due_date)
    @items << item
  end

  # Parse JSON from the Todo.json file
  def load_from_file
    # Protects against the file being empty
    if File.zero?(@file) || File.exists?(@file) == false
      return
    end
    file = File.read(@file)
    item_array = get_parsed_json
    unless item_array == nil
      item_array.each do |item|
        date = item["due_date"]
        item = Item.new(item["description"], date, item["completion_status"])
        @items << item
      end
    end
  end

  def get_parsed_json
    file = File.read(@file)
    return JSON.parse(file)
  rescue JSON::ParserError => e
    return nil
  end

  def items_to_json
    array = Array.new
    @items.each do |item|
      array << item.hash_me
    end
    return array.to_json
  end

  def output_to_file!
    File.new(@file, 'w+')
    File.open(@file, 'w') do |file|
      file.write(items_to_json)
    end
  end

  def remove_item(index)
    @items.delete_at(index)
  end

  def change_status(index, status)
    @items[index].update_status!(status)
  end

  def output
    output = ""
    output << @title
    output << "\n---------\n"
    @items.each_with_index do |item, index|
      output << "#{index + 1} - #{item.description}\n"
      output << "Status: #{item.is_complete? ? "Complete" : "Not Complete"}\n"
      output << "Due Date: #{item.due_date.as_string}\n"
      output << "Overdue: #{item.is_overdue? ? "Yes" : "No"}\n\n"
    end
    return output # I know that we don't need to call output, but I think it makes the intention clear
  end
end

class Item
  attr_reader :description, :due_date
  attr_accessor :completion_status

  # Initialize with variables.  Due_date MUST be a string.
    # Normall
  def initialize(item_description, due_date = Date.now, completion_status = false)
    @description = item_description
    @completion_status = completion_status
    @due_date = due_date.as_date
  end

  def update_status!(complete)
    @completion_status = complete
  end

  def hash_me # Similiar to the common coloquial beer me, the hash me gives you a hash
    item_hash = { :description => @description, :completion_status => @completion_status == "Complete" ? true : false, :due_date => @due_date }
    return item_hash
  end

  def is_complete?
    return self.completion_status
  end

  def is_overdue?
    now = DateTime.now
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
