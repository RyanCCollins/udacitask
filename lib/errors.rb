module UdaciListErrors
  class DateArgumentError < ArgumentError
  end

  class IndexExceedsListSize < StandardError
  end

  class InvalidItemType < StandardError
  end

  class InvalidFilter < StandardError
  end

  class InvalidPriorityValue < StandardError
  end
end
