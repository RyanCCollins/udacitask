require 'chronic'

class TodoItem
  # Include the listable module
  include Listable
  # attr_accessor and readers for required elements.
    # description and complete need to be written to by webapp.
  attr_accessor :description, :complete
  attr_reader :due, :priority, :id

  def initialize(description, options={})
    @id = Listable.get_next_id
    @title = options[:title] ? options[:title] : "N/A"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @complete = false # Set to false by default when initialized.
  end

  def details
    format_description(@description) + "due: " +
    format_date(start_date: @due) +
    format_priority(@priority)
  end
end
