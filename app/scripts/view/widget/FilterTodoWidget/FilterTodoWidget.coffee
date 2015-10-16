define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'

  $ = Backbone.$

  FilterTodoWidget = Backbone.Epoxy.View.extend
    template: $('#FilterTodoWidget').html()

    className: 'filter-todo-widget'

    filters:
      title: ''
      done: 'all'

    ui:
      $title: '[data-js-todo-title]'
      $done: '[data-js-todo-done]'

    events:
      'input [data-js-todo-title]': 'onTitleInput'
      'change [data-js-todo-done]': 'onDoneChange'

    initialize: ->
      @$el.html @template
      @render()
      @setUi()

    setUi: ->
      ui = {}
      _.each @ui, (element, key)=>
        ui[key] = @$(element)
      @ui = ui

    onTitleInput: (e) ->
      @filters.title = $(e.target).val()
      @setFilters @filters

    onDoneChange: (e) ->
      @filters.done = $(e.target).val()
      @setFilters @filters

    setFilters: (filters)->
      @filters = filters
      @collection.setFilters @filters.title, @filters.done
      @ui.$title.val @filters.title if @filters.title
      @ui.$done.val @filters.done if @filters.done
      @updateRoute()

    updateRoute: ->
      routeStr = ''
      routeStr += '?title=' + @filters.title if @filters.title
      if @filters.done and @filters.done != 'all'
        routeStr += if routeStr.length then '&' else '?'
        routeStr += 'done=' + @filters.done
      window.common.router.navigate routeStr
