define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoModel = require 'model/TodoModel'
  localStorage = require 'backbone.localStorage'

  TodoFilteredCollection = Backbone.Collection.extend

    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-filtered-backbone"

    filters:
      title: ''
      done: 'all'

    initialize: (models, options)->
      @originalCollection = options.originalCollection
      @listenTo @originalCollection, 'change', @sync
      @sync()

    sync: ()->
      models = _.filter @originalCollection.models, (item) =>
        item.isMatchFilters @filters.title, @filters.done
      @set models
      @trigger 'sync'

    setTitleFilter: (title)->
      @filters.title = title
      @sync()

    setDoneFilter: (done)->
      @filters.done = done
      @sync()

    setFilters: (title='', done='all')->
      @setTitleFilter title
      @setDoneFilter done


