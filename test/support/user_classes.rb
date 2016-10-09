class User < Struct.new(:id, :name)
  def self.cache_key
    'cache_key'
  end

  def self.find(tag_attribute_value)
  end

  def to_s
    name
  end
end

class UserTag < Hashtags::User
  def self.resource_class
    ::User
  end

  def self.tag_attribute
    :id
  end

  def self.result_attribute
    :name
  end

  def resource(tag_attribute_value)
    self.class.resource_class.find(tag_attribute_value)
  end
end