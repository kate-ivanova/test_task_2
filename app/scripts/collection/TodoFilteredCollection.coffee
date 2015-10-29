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

    # REVIEW: не очень понятно по названию, что именно синхронизирует метод
    sync: (title='', done='all')->
      models = _.filter @originalCollection.models, (item) =>
        item.isMatchFilters title, done
      @set models
      @trigger 'sync'

    # REVIEW: этот метод не используется
    # Все методы 3 метода можно заменить одним setFilters,
    # принимающий объекто в качестве параметров
    # Так же выразительно, но более гибко и расширяемо
    # setFilters {title: 'Наввание'}
    # setFilters {done: true}
    # setFilters {title: 'Абыр Валг',done: true}
    setTitleFilter: (title)->
      @sync title

    setDoneFilter: (done)->
      @sync null, done

    setFilters: (title='', done='all')->
      @sync title, done
