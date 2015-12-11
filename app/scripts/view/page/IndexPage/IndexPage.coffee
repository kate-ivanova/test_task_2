define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoFilteredCollection = require 'collection/TodoFilteredCollection'
  TodoListView = require 'view/list/TodoListView/TodoListView'
  AddTodoWidget = require 'view/widget/AddTodoWidget/AddTodoWidget'
  FilterTodoWidget = require 'view/widget/FilterTodoWidget/FilterTodoWidget'
  IndexPageTemplate = require 'jade!view/page/IndexPage/IndexPage'

  $ = Backbone.$

  IndexPage = Backbone.Epoxy.View.extend
    className: 'app-block'

    template: IndexPageTemplate()

    # круто!
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
      # REVIEW: это лучше передававать в конструктор
      @regions.addTodo.collection = @collection
      @regions.filterTodo.collection = @filteredCollection
      @regions.todoList.collection = @filteredCollection
      # render all
      @render()
      @initializeRegions()

    # REVIEW: этот код лучше вынести в общего родителя или создать миксин
    # REVIEW: например так https://coffeescript-cookbook.github.io/chapters/classes_and_objects/mixins
    initializeRegions: ->
      regions = {}
      _.each @regions, (region, key)=>
        regions[key] = new @regions[key].view (el: @$(@regions[key].el), collection: @regions[key].collection)
      @regions = regions
      # REVIEW: скорее всего этот вызов лучше себя будет чуствоавть в initialize
      # REVIEW: а может быть и нет)
      @renderRegions()

    renderRegions:->
      _.each @regions, (region)=>
        region.render()

    setAttributes: (filters) ->
      @regions.filterTodo.setFilters filters if filters

    # этот код повторяется
    hide: -> @$el.toggleClass 'hide', true

    show: -> @$el.toggleClass 'hide', false



