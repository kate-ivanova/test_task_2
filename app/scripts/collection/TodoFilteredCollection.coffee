define ['backbone', 'todoModel', 'backbone.localStorage'], (Backbone, TodoModel, localStorage) ->
  TodoFilteredCollection = Backbone.Collection.extend
    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-filtered-backbone"

    # REVIEW: очень похоже на то, что ты хотела использовать модель, но забыла об этом
    filters:
      title: ''
      done: 'all'

    initialize: (models, options)->
      @originalCollection = options.originalCollection
      @listenTo @originalCollection, 'update', @sync
      @listenTo @originalCollection, 'change', @sync
      @sync()

    # REVIEW: очень важно, но без подсказок. сделай этот метод короче и понятней
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
      @sync('title')

    setDoneFilter: (done)->
      @filters.done = done
      @sync('done')
