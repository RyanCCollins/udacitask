class TodoList
  attr_accessor :title
  attr_reader :items

  def initialize(list_title)
    @title = list_title
    @items = Array.new
    @file = @title + ".txt"
  end

  def add_new_item(new_item)
    item = Item.new(new_item)
    @items << item
  end

  def remove_item(index)
    @items.delete_at(index)
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
      output << "Status: #{item.is_complete? ? "Completed" : "Not Completed"}\n\n"
    end
    puts output
    return output
  end
end

class Item
  attr_reader :description
  attr_accessor :completion_status

  def initialize(item_description)
    @description = item_description
    @completion_status = false
  end
  def update_status!(complete)
    @completion_status = complete
  end
  def is_complete?
    return self.completion_status
  end
end