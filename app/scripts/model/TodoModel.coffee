define (require, exports, module) ->
  Backbone = require 'backbone'

  TodoModel = Backbone.Model.extend
    defaults:
      title: 'Новая задача'
      done: false

    initialize: -> @save()

    toggle: -> @save done: !@get 'done'

    changeTitle: (newTitle)-> @save title: newTitle

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



