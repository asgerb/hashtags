#= require jquery-textcomplete

# https://github.com/zenorocha/jquery-boilerplate
(($, window) ->
  pluginName = 'hashtags'
  document = window.document

  defaults =
    debug: false

  class Plugin
    constructor: (@element, options) ->
      @options = $.extend {}, defaults, options

      @$element = $(@element)

      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      @$element.textcomplete(@get_strategies())

    get_default_path: -> @$element.data 'hash-tag-path'
    get_strategies: -> $.map @$element.data('hash-tag-strategies'), (strategy) => @get_strategy(strategy)
    get_strategy: (data) ->
      {
        index: data.match_index
        cache: true
        context: (text) -> text.toLowerCase()
        match: ///#{data.match_regexp}///
        search: (term, callback, match) =>
          if data.values
            @search_values(data, term, callback, match)
          else
            @search_remote(data, term, callback, match)
        replace: (resource, event) -> Handlebars.compile(data.replace)(resource)
        template: (resource, term) -> Handlebars.compile(data.template)(resource)
      }

    search_values: (data, term, callback, match) ->
      callback $.map( data.values, (value) ->
        if value.match(///^#{term}///i) then value else null
      )

    search_remote: (data, term, callback, match) ->
      url = data.path ? @get_default_path()
      match_template = data.match_template

      $.getJSON( url , q: term, class_name: data.class_name )
        .done( (resp) ->
          callback $.map( resp, (resource) ->
            if Handlebars.compile(match_template)(resource).match(///#{term}///i) then resource else null
          )
        )
        .fail -> callback []

  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new Plugin(@, options))

)(jQuery, window)

$ -> $('input[type="text"][data-hash-tag-strategies], textarea[data-hash-tag-strategies]').hashtags()