require 'uri'

class Blog

  include DataMapper::Resource

  has n, :tags, :through => Resource
  belongs_to :user, :required => false

  property :id,     Serial
  property :url,    String, :unique => true

  attr_reader :url

  validates_uniqueness_of :url

  def good_url
    self.url.include?('http://') ? self.url : ("http://") + self.url
  end

  def clean_url
    URI.parse(good_url.gsub('www.','')).host
  end

end
