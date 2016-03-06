class LinkItem
  include Listable
  attr_reader :description, :site_name, :id

  @@next_id = 0 # Start an incrementing ID counter

  def initialize(url, options={})
    @id = @@next_id
    @@next_id += 1
    @description = url
    @site_name = options[:site_name]
  end

  def format_name
    @site_name ? @site_name : ""
  end
  def details
    format_description(@description) + "site name: " + format_name
  end
end
