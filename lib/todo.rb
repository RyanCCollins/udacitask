require 'chronic'

class TodoItem
  include Listable
  attr_writer :description, :complete
  attr_reader :due, :priority, :id, :description, :complete

  def initialize(description, options={})
    @id = Listable.get_next_id
    @title = options[:title] ? options[:title] : "N/A"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @complete = false
  end

  def details
    format_description(@description) + "due: " +
    format_date(start_date: @due) +
    format_priority(@priority)
  end
end
