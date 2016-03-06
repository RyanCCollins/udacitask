class UdaciList
  attr_reader :title, :items

  @@list_types = ["todo", "event", "link"]
  @@list_items = []

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Unknown Title"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    # A bit repetitive to push these both onto class and instance vars
      # But for the purposes of showing a UdaciList.all method, it makes sense
    @@list_items << construct_item(type, description, options)
    @items << construct_item(type, description, options)
  end

  # Get one by id from the the list items
  def self.get_one id
    all.detect {|item| item.id == id }
  end

  def self.all
    @@list_items.sort_by { |item| item.id } # Sort by item id to give a list by id
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

  def destroy! # Deletes a list item by calling item.destroy
    @items.delete(self)
  end

  def delete index # Deletes an item at the given index
    if index_exists? index
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize, "The index #:#{index} does not exist in the UdaciList list (list length: #{@items.length})"
    end
  end

  def index_exists? index
    return index < @items.length # Return true if the index is less than the length
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

