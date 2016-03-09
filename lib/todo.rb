require 'chronic'

# Class TodoItem is another class that stores data for a list item, albeit for todos
class TodoItem
  # Include the listable module
  include Listable

  # Class variable for the type of list
  @@type = "todo"

  # attr_accessor and readers for required elements.
    # description needs to be written to by webapp.
  attr_accessor :description
  attr_reader :due, :priority, :id

  # Standard initialize method
  def initialize(description, options={})
    @id = Listable.get_next_id # Get the next id from the listable module
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
    # Print the type of item
    "#{@@type.capitalize}: " +
    format_description(@description) + "due: " + format_date(start_date: @due) +
    format_priority(@priority)
  end
end
