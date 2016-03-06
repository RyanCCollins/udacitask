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
    case priority
    when "high"
      value = "⇧".red
    when "medium"
      value = "⇧".yellow
    when "low"
      value = "⇨".blue
    when nil
      value = ""
    else
      raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Value: #{priority}"
    end
  end
end
