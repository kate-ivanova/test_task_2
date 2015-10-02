define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoCollection = require 'todoCollection'
  TodoFilteredCollection = require 'todoFilteredCollection'
  TodoListView = require 'todoListView'
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
      @filteredCollection = new TodoFilteredCollection null, originalCollection: @collection
      @initializeRegions()

    initializeRegions: ->
      regionsKeys = _.keys @regions
      _.each @regions, (region, key)=>
        @regions[key] = new @regions[key].view
      @regions.addTodo.collection = @collection
      @regions.filterTodo.collection = @filteredCollection
      @regions.todoList.setCollection @filteredCollection

    render:->
      @$el.html @template
      _.each @regions, (region)=>
        region.render()

    setAttributes: (filters) ->
      @regions.filterTodo.setFilters filters if filters


