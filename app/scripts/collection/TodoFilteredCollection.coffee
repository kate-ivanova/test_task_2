define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoModel = require 'todoModel'
  localStorage = require 'backbone.localStorage'

  TodoFilteredCollection = Backbone.Collection.extend

    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-filtered-backbone"

    filters:
      title: ''
      done: 'all'

    initialize: (models, options)->
      @originalCollection = options.originalCollection
      @listenTo @originalCollection, 'update', @sync
      @listenTo @originalCollection, 'change', @sync
      @sync()

    sync: ()->
      models = _.filter(@originalCollection.models, (item)=>
        if(!@hasTitleFilter() && !@hasDoneFilter())
          return true
        else
          if(@hasTitleFilter())
            if(@hasDoneFilter())
              return (((item.get 'title').toLowerCase().indexOf(@filters.title.toLowerCase()) >= 0) &&
                ('' + item.get('done')) == @filters.done)
            else
              return ((item.get 'title').toLowerCase().indexOf(@filters.title.toLowerCase()) >= 0)
              return ((item.get 'title').toLowerCase().indexOf(title.toLowerCase()) >= 0)
          else
            if(@hasDoneFilter())
              return (('' + item.get('done') == @filters.done))
        return false
      )
      @set models

    hasTitleFilter: ->
      return @filters.title.length

    hasDoneFilter: ->
      return (@filters.done != 'all')

    setTitleFilter: (title)->
      @filters.title = title
      @sync()

    setDoneFilter: (done)->
      @filters.done = done
      @sync()
