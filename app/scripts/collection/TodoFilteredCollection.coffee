define (require, exports, module) ->
  TodoModel = require 'model/TodoModel'

  TodoFilteredCollection = Backbone.Collection.extend

    model: TodoModel

    initialize: (models, options)->
      @filters = {}
      if options and options.originalCollection
        @_setOriginalCollection options.originalCollection

    setFilters: (filters)->
      @filters = filters
      @_refresh()

    _setOriginalCollection: (originalCollection)->
      @originalCollection = originalCollection
      @listenTo @originalCollection, 'change add reset remove', @_refresh
      @_refresh()

    _refresh: ->
      if @originalCollection
        models = _.filter @originalCollection.models, (item) =>
          (@_isMatchTitleFilter item, @filters.title) && (@_isMatchDoneFilter item, @filters.done)
        @set models
      @trigger 'refresh'

    _isMatchTitleFilter: (item, titleFilter='')->
      return true if not titleFilter.length
      title = (item.get 'title').toLowerCase()
      titleFilter = titleFilter.toLowerCase()
      (title.indexOf titleFilter) >= 0

    _isMatchDoneFilter: (item, doneFilter='all')->
      return true if doneFilter == 'all'
      ('' + item.get 'done') == '' + doneFilter
