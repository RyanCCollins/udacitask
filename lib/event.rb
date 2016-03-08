class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :id

  def initialize(description, options={})
    @id = Listable.get_next_id
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
  end

  def details
    "Event: " + # I may have misunderstood the specs, but it says to print the type.
    format_description(@description) + "event dates: " + format_date(start_date:@start_date, end_date: @end_date)
  end
end
