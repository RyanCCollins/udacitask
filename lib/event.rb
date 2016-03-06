class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date, :id

  @@next_id = 0 # Start an incrementing ID counter

  def initialize(description, options={})
    @id = @@next_id
    @@next_id += 1
    @description = description
    @start_date = Date.parse(options[:start_date]) if options[:start_date]
    @end_date = Date.parse(options[:end_date]) if options[:end_date]
  end

  def details
    format_description(@description) + "event dates: " + format_date(start_date:@start_date, end_date: @end_date)
  end
end
