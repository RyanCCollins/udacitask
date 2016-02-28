require 'date' # We have to load the date class to compare dates for due date
require 'json'

class TodoList
  attr_accessor :title
  attr_reader :items

  def initialize(list_title)
    @title = list_title
    @items = Array.new
    @file = @title + ".json"
  end

  def add_new_item(new_item)
    item = Item.new(new_item)
    @items << item
  end

  def load_from_file
    file = File.read(@file)
    item_array = JSON.parse(file)
    item_array.each do |item|
      date = Date.parse(item["due_date"])
      item = Item.new(item["description"], date, item["completion_status"])
      @items << item
    end
  end

  def output_to_file!(output)
    File.new(@file, 'w+')
    File.open(@file, 'w') do |file|
      file.write(items_to_json)
    end
  end

  def remove_item(index)
    @items.delete_at(index)
  end

  def items_to_json
    array = Array.new
    @items.each do |item|
      array << item.hash_me
    end
    return array.to_json
  end

  def change_status(index, status)
    @items[index].update_status!(status)
  end

  def output!
    output = ""
    output << @title
    output << "\n---------\n"
    @items.each_with_index do |item, index|
      output << "#{index + 1} - #{item.description}\n"
      output << "Status: #{item.is_complete? ? "Complete" : "Not Complete"}\n"
      output << "Due Date: #{item.due_date}\n"
      output << "Overdue: #{item.is_overdue? ? "Yes" : "No"}\n\n"
    end
    output_to_file!(output)
    puts output
  end
end

class Item
  attr_reader :description, :due_date
  attr_accessor :completion_status

  def initialize(item_description, due_date = Time.now.to_date, completion_status = "Not Complete")
    @description = item_description
    @completion_status = completion_status
    @due_date = due_date
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
    now = Time.now.to_date
    return @due_date < now
  end
end