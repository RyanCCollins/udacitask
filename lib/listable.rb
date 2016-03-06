require 'colorize'

module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date options = {}
    dates = options[:start_date].strftime("%D") if options[:start_date]
    dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
    dates = "N/A" if !dates
  return dates
  end

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
