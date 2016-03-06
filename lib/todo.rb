require 'chronic'

class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :complete, :id

  @@next_id = 0 # Start an incrementing ID counter

  def initialize(description, options={})
    @id = @@next_id
    @@next_id += 1
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
