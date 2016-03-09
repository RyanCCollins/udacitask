# Loading the types so that we can use their names to build items
require_relative 'todo'
require_relative 'link'
require_relative 'event'

class UdaciList
  attr_reader :title, :items
  # Define the list types for easy reference
  @@list_types = { todo: TodoItem, link: LinkItem, event: EventItem }
  @@all_items = []

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end

  # Push a newly constructed item onto the class and instance items array
  def add(type, description, options={})
    type = type.downcase
    add_item construct_item(type, description, options)
  end

  # Add the item to both the class and instance
    # Since we want a convenient way to get all items from the webapp
    # Realistically, we would elimate this and use the .filter method
    # To get lists, but for the purposes of this project,
    # We are utilizing two seperate arrays at instance and class levels.
  def add_item item
    @items << item
    @@all_items << item
  end

  # Get one by id from the the list items
  def self.get_one id
    all.detect {|item| item.id == id }
  end

  # Convenience for deleting from the class list (will not delete from instance list)
  def self.delete id
    # Call self.all to delete an item from the web app list
    item_index = all.find_index { |item| item.id == id }
    all.delete_at item_index
  end

  def self.all
    @@all_items
  end

  # Convenience for getting all todo items from webapp
  def self.all_todo_items
    all.select { |item| item.is_a? TodoItem }
  end

  # Constructor for building items
    # Takes a type, description and options
    # and returns an object of that type.
  def construct_item type, description, options
    type = type.downcase
    if type_allowed? type
      # Create and return a new item of the type passed in
      @@list_types[type.to_sym].new(description, options)
    else
      # Raise the invalid item type error if the type does not exist
      raise UdaciListErrors::InvalidItemType if !type_allowed? type
    end
  end

  # Delete an item by passing in the list item number
    # will delete the item that matches the item_number - 1
    # i.e. item number 3 will delete at index 2.
  def delete item_number
    index = item_number - 1
    if index_exists? index, @items
      @items.delete_at index
    else
      raise UdaciListErrors::IndexExceedsListSize, "List item #{index + 1} does not exist in the UdaciList list"
    end
  end

  # Determine if an index exists in a given list.
  def index_exists? index, list
    return index < list.length # Return true if the index is less than the length
  end

  # Check if the type exists?
  def type_allowed? type # Will check if the type is included in the list_types hash
    return @@list_types.keys.include?(type.to_sym)
  end

  # Filter by type by selecting items from the list based on type
  def filter type
    if type_allowed?(type.downcase) # Downcase the filter type and check if it's allowed (exists in lists)
      list_type = @@list_types[type.downcase.to_sym]
      @items.select { |item| item.is_a? list_type }
      # Set the title equal to the filter and output the
        # Header and items (as long as there are items to put)
      @title = "Filtered by: " + type.capitalize
      puts header
      puts output_for items if items
    else
      raise InvalidFilter, "Invalid Filter: #{filter}"
    end
  end

  # Convenience for compiling output for any items passed in
    # Useful for compiling the output for the all method and
    # For a filtered list
  def output_for items
    output = ""
    items.each_with_index do |item, position|
      output += "#{position + 1}) #{item.type.capitalize}: #{item.details}\n"
    end
    output # Return the output to print (well, put) it
  end

  # Creates a header that matches the length of
    # The title.
  def header_for_title
    output = "-" * @title.length
  end

  def header # Create a header and return it
    output = header_for_title + "\n" +
                  @title + "\n" + header_for_title
  end

  # Will output all the list's items
  def all
    puts header
    puts output_for @items
  end
end
