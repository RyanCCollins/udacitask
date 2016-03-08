class UdaciList
  attr_reader :title, :items
  # Define the list types for easy reference
  @@list_types = ["todo", "event", "link"]
  @@all_items = []

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Unknown Title"
    @items = []
  end

  # Push a newly constructed item onto the @items array
  def add(type, description, options={})
    type = type.downcase

    add_item construct_item(type, description, options)
  end

  # Add the item to both the class and instance
    # Since we want a convenient way to get all items
  def add_item item
    @items << item
    @@all_items << item
  end

  # Get one by id from the the list items
  def self.get_one id
    all.detect {|item| item.id == id }
  end

  # Convenience for deleting from the class list
  def self.delete id
    item = self.all.select { |item| item.id == id }
    all.delete item
  end

  def self.all
    @@all_items
  end

  # Convenience for getting all todo items from webapp
  def self.all_todo_items
    self.all.select { |item| item.is_a? TodoItem }
  end

  def construct_item type, description, options
    case type
    when "todo"
      return TodoItem.new(description, options)
    when "event"
      return EventItem.new(description, options)
    when "link"
      return LinkItem.new(description, options)
    else
      # Raise the invalid item type error if the type does not exist
      raise UdaciListErrors::InvalidItemType if !type_exists? type
    end
  end

  def delete index # Deletes an item at the given index
    if index_exists? index, @items
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize, "The index #:#{index} does not exist in the UdaciList list (list length: #{@items.length})"
    end
  end

  def index_exists? index, list
    return index < list.length # Return true if the index is less than the length
  end

  # Check if the type exists?
  def type_exists? type
     return @@list_types.include? type
  end

  def filter filter
    filter.downcase! # Do what I say!
    case filter
    when "event"
      items = @items.select { |item| item.is_a? EventItem }
    when "todo"
      items = @items.select { |item| item.is_a? TodoItem }
    when "link"
      items = @items.select { |item| item.is_a? LinkItem }
    when "complete" # Check for completion
      items = @items.select { |item| item.respond_to?(:is_complete?) && item.is_complete? }
    when "incomplete"
      items = @items.select { |item| item.respond_to?(:is_complete?) && !item.is_complete? }
    else
      raise InvalidFilter, "Invalid Filter: #{filter}"
    end
  end

  def header_for_title
    output = "-"
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
