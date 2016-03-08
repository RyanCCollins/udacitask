require 'chronic'

class TodoItem
  # Include the listable module
  include Listable
  # attr_accessor and readers for required elements.
    # description and complete need to be written to by webapp.
  attr_accessor :description
  attr_reader :due, :priority, :id

  def initialize(description, options={})
    @id = Listable.get_next_id
    @title = options[:title] ? options[:title] : "N/A"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @complete = false # Set to false by default when initialized.
  end

  # Safety method for toggling completion status
  def toggle_completion status
    @complete = status
  end

  # Convenience for checking if the item is complete.
  def complete?
    return @complete
  end

  def details
    "Todo: " +
    format_description(@description) + "due: " +
    format_date(start_date: @due) +
    format_priority(@priority)
  end
end
