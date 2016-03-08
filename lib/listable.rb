require 'colorize'

# Module listable creates a reusable module that we can include in any list.
module Listable
  @@next_list_id = 0 # Define the next list id within listable to make sure it is a new id.

  # Increment the next id and then return it.
  def self.get_next_id
    @@next_list_id += 1
    return @@next_list_id
  end

  # Convenience for formatting the description
  def format_description(description)
    "#{description}".ljust(30)
  end

  # Format the dates in a readable format.
    # Pass in either a start_date or both a start and end_date
    # Return N/A if no date passed in.
  def format_date options = {}
    dates = options[:start_date].strftime("%D") if options[:start_date]
    dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
    dates = "N/A" if !dates
  return dates
  end

  # Format the priority and colorize it accordingly
  def format_priority priority
    # Set the priority symbols and color
    case priority
    when "high"
      value = " ⇧".red # High Priority shows red up arrow
    when "medium"
      value = " ⇨".yellow # Medium priority shows yellow right arrow
    when "low"
      value = " ⇩".blue # Low priority shows blue down arrow
    when nil
      value = ""
    else
      raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Value: #{priority}"
    end
  end
end
