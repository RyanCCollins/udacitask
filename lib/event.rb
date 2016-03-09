# Load the chronic gem for date parsing
require 'chronic'

# Class EventItem is another class that stores data for a list item, albeit for events
class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :id

  def initialize(description, options={})
    @id = Listable.get_next_id
    @type = "event"
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end

  def details
    # Print the type of item
    "#{@type.capitalize} :" +
    format_description(@description) + "event dates: " + format_date(start_date:@start_date, end_date: @end_date)
  end
end
