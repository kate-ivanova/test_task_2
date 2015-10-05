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
      @collection.setFilters @filters
      if @filters.title
        @ui.$title.val @filters.title
      if @filters.done
        @ui.$done.val @filters.done
      @updateRoute()

    updateRoute: ->
      routeStr = ''
      if @filters.title
        routeStr += '?title=' + @filters.title
      if @filters.done && @filters.done != 'all'
        if routeStr.length
          routeStr += '&'
        else
          routeStr += '?'
        routeStr += 'done=' + @filters.done
      window.common.router.navigate routeStr
