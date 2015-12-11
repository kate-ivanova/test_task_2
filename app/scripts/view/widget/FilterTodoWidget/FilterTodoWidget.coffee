define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  FilterTodoWidgetTemplate = require 'jade!view/widget/FilterTodoWidget/FilterTodoWidget'
  $ = Backbone.$

  FilterTodoWidgetModel = Backbone.Model.extend
    defaults:
      title: ''
      done: 'all'

  FilterTodoWidget = Backbone.Epoxy.View.extend
    template: FilterTodoWidgetTemplate()
    className: 'filter-todo-widget'

    ui:
      title: '[data-js-todo-title]'
      done: '[data-js-todo-done]'

    events:
      'input [data-js-todo-title]': 'onTitleInput'
      'change [data-js-todo-done]': 'onDoneChange'

    initialize: ->
      @model = new FilterTodoWidgetModel
      @$el.html @template
      @render()
      @_setUi()

    _setUi: ->
      ui = {}
      _.each @ui, (element, key)=>
        ui[key] = @$(element)
      @ui = ui

    _setFilters: (filters)->
      _.each _.keys(filters), (key)=>
        @model.set {"#{key}": filters["#{key}"]}
        @ui["#{key}"].val filters["#{key}"]
      @collection.setFilters @model.toJSON()
      @_updateRoute()

    _updateRoute: ->
      routeStr = ''
      filters = @model.toJSON()
      # REVIEW: string templates! http://coffeescript.org/#strings
      routeStr += '?title=' + filters.title if filters.title
      if filters.done and filters.done != 'all'
        routeStr += if routeStr.length then '&' else '?'
        routeStr += 'done=' + filters.done
      window.common.router.navigate routeStr

    onTitleInput: (e) -> @_setFilters {title: $(e.target).val()}

    onDoneChange: (e) -> @_setFilters {done: $(e.target).val()}
