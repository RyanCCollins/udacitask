class UdaciList
  attr_reader :title, :items

  @@list_types = ["todo", "event", "link"]

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Unknown Title"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    # Raise the invalid item type error if the type does not exist
    raise UdaciListErrors::InvalidItemType if !type_exists? type
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
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
    when "complete"
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

