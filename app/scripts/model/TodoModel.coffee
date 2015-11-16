define (require, exports, module) ->
  Backbone = require 'backbone'

  TodoModel = Backbone.Model.extend
    defaults:
      title: ''
      done: false

    toggle: ->
      @set done: !@get 'done'

    changeTitle: (newTitle)->
      @set title: newTitle

    validate: (attrs)->
      'cannot have an empty title' if not attrs.title

    # фильтрацию лучше реализовывать на уровне коллекции
    # по идее модель об этой части поведения должна знать минимум
    isMatchFilters: (titleFilter='', doneFilter='all')->
      titleFilterMatch = @isMatchTitleFilter titleFilter
      doneFilterMatch = @isMatchDoneFilter doneFilter
      titleFilterMatch && doneFilterMatch

    isMatchTitleFilter: (titleFilter='')->
      if titleFilter.length
        title = (@get 'title').toLowerCase()
        titleFilter = titleFilter.toLowerCase()
        (title.indexOf titleFilter) >= 0
      else
        true

    isMatchDoneFilter: (doneFilter='all')->
      if doneFilter != 'all'
        done = '' + @get 'done'
        done == doneFilter
      else
        true
