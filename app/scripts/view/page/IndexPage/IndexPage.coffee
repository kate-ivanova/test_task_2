define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  BackboneMixin = require 'backbone-mixin'
  TodoCollection = require 'todoCollection'
  TodoFilteredCollection = require 'todoFilteredCollection'
  TodoListView = require 'todoListView'
  $ = Backbone.$

  IndexPage = BackboneMixin(Backbone.Epoxy.View).extend
    className: 'app-block'

    template: '#IndexPage'

    filters:
      title: ''
      done: 'all'

    ui:
      todoList: '[data-js-todo-list]'
      newTodoTitle: '[data-js-todo-add-title]'
      doneFilter: '[data-js-todo-filter-done]'
      titleFilter: '[data-js-todo-filter-title]'
      todoAddButton: '[data-js-todo-add-submit]'

    events:
      'click [data-js-todo-add-submit]': 'onAddClick'
      'keypress [data-js-todo-add-title]': 'onAddTitleKeypress'
      'input [data-js-todo-filter-title]': 'onTitleFilterInput'
      'change [data-js-todo-filter-done]': 'onDoneFilterChange'

    initialize: (options) ->
      @collection = new TodoCollection()
      @filteredCollection = new TodoFilteredCollection null, originalCollection: @collection
      if options.title
        @filters.title = options.title
        @filteredCollection.setTitleFilter @filters.title
      if options.done
        @filters.done = options.done
        @filteredCollection.setDoneFilter @filters.done

    render: ->
      @todoListView = new TodoListView collection: @filteredCollection
      @ui.todoList.append @todoListView.render().$el
      if @filters.title
        @ui.titleFilter.val @filters.title
      if @filters.done
        @ui.doneFilter.val @filters.done
      this

    onAddClick: ->
      @addTodoItem @ui.newTodoTitle.val()
      @ui.newTodoTitle.val ''

    onAddTitleKeypress: (e)->
      @onAddClick() if (e.keyCode == 13)

    onTitleFilterInput: (e) ->
      @filters.title = $(e.target).val()
      @filteredCollection.setTitleFilter @filters.title
      @updateRoute()

    onDoneFilterChange: (e) ->
      @filters.done = $(e.target).val()
      @filteredCollection.setDoneFilter @filters.done
      @updateRoute()

    addTodoItem: (title)->
       @collection.addNewItem title: title

    setFilters: (filters)->
      @filters = filters
      @filteredCollection.setFilters @filters

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
