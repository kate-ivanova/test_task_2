define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoFilteredCollection = require 'collection/TodoFilteredCollection'
  TodoListView = require 'view/list/TodoListView/TodoListView'
  AddTodoWidget = require 'view/widget/AddTodoWidget/AddTodoWidget'
  FilterTodoWidget = require 'view/widget/FilterTodoWidget/FilterTodoWidget'

  $ = Backbone.$

  IndexPage = Backbone.Epoxy.View.extend
    className: 'app-block'

    template: $('#IndexPage').html()

    regions:
      addTodo:
        el: '[data-js-todo-add]'
        view: AddTodoWidget
      filterTodo:
        el: '[data-js-todo-filter]'
        view: FilterTodoWidget
      todoList:
        el: '[data-js-todo-list]'
        view: TodoListView

    initialize: ->
      @$el.html @template
      @filteredCollection = new TodoFilteredCollection null, originalCollection: @collection
      # set collections for view
      @regions.addTodo.collection = @collection
      @regions.filterTodo.collection = @filteredCollection
      @regions.todoList.collection = @filteredCollection
      # render all
      @render()
      @initializeRegions()

    initializeRegions: ->
      regions = {}
      _.each @regions, (region, key)=>
        regions[key] = new @regions[key].view (el: @$(@regions[key].el), collection: @regions[key].collection)
      @regions = regions
      @renderRegions()

    renderRegions:->
      _.each @regions, (region)=>
        region.render()

    setAttributes: (filters) ->
      @regions.filterTodo.setFilters filters if filters

    hide: -> @$el.toggleClass 'hide', true

    show: -> @$el.toggleClass 'hide', false



