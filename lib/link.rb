class LinkItem
  include Listable
  attr_reader :description, :site_name, :id

  def initialize(url, options={})
    @id = Listable.get_next_id
    @description = url
    @site_name = options[:site_name]
  end

  # Format the name.  If it doesn't exist, then set it to ""
  def format_name
    @site_name ? @site_name : ""
  end

  def details
    format_description(@description) + "site name: " + format_name
  end
end
