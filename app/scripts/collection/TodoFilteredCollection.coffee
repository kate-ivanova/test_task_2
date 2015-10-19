define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoModel = require 'model/TodoModel'
  localStorage = require 'backbone.localStorage'

  TodoFilteredCollection = Backbone.Collection.extend

    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-filtered-backbone"

    initialize: (models, options)->
      @originalCollection = options.originalCollection
      @listenTo @originalCollection, 'change', @sync
      @sync()

    sync: (title='', done='all')->
      models = _.filter @originalCollection.models, (item) =>
        item.isMatchFilters title, done
      @set models
      @trigger 'sync'

    setTitleFilter: (title)->
      @sync title

    setDoneFilter: (done)->
      @sync null, done

    setFilters: (title='', done='all')->
      @sync title, done
