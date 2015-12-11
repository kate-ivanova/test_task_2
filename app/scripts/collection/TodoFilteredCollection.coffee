define (require, exports, module) ->
  TodoModel = require 'model/TodoModel'
  localStorage = require 'backbone.localStorage'

  TodoFilteredCollection = Backbone.Collection.extend

    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-filtered-backbone"

    initialize: ->
      @filters = {}

    setOriginalCollection: (originalCollection)->
      @originalCollection = originalCollection
      @listenTo @originalCollection, 'change', @_refresh
      @_refresh()

    _refresh: ->
      if @originalCollection
        models = _.filter @originalCollection.models, (item) =>
          (@isMatchTitleFilter item, @filters.title) && (@isMatchDoneFilter item, @filters.done)
        @set models
      @trigger 'refresh'

    isMatchTitleFilter: (item, titleFilter='')->
      return true if not titleFilter.length
      title = (item.get 'title').toLowerCase()
      titleFilter = titleFilter.toLowerCase()
      (title.indexOf titleFilter) >= 0

    isMatchDoneFilter: (item, doneFilter='all')->
      return true if doneFilter == 'all'
      ('' + item.get 'done') == '' + doneFilter

    setFilters: (filters)->
      @filters = filters
      @_refresh()
