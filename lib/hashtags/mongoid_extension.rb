require 'mongoid'
require 'ostruct'

Mongoid::Fields.option :hashtags do |cls, field, value|
  return if value == false

  cls.define_singleton_method(:hashtags) { @hashtags ||= {} } unless cls.respond_to?(:hashtags)
  options = value.is_a?(Hash) ? value.slice(*%i(only except)) : {}

  cls.hashtags[field.name] ||= OpenStruct.new(
    dom_data: Hashtags::Builder.dom_data(options),
    help: Hashtags::Builder.help(options),
    options: options
  )

  field.define_singleton_method :demongoize do |*args|
    res = super(*args)
    res.define_singleton_method :to_markup do
      Hashtags::Builder.to_markup(res.to_s, options)
    end
    res.define_singleton_method :to_hashtag do
      Hashtags::Builder.to_hashtag(res.to_s, options)
    end
    res
  end

  field.define_singleton_method :mongoize do |value|
    Hashtags::Builder.to_hashtag(super(value.to_s), options)
  end
end
