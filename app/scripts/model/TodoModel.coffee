define (require, exports, module) ->
  Backbone = require 'backbone'

  TodoModel = Backbone.Model.extend
    defaults:
      title: 'Новая задача'
      done: false

    initialize: ->
      @save()

    toggle: ->
      @save done: !@get 'done'

    changeTitle: (newTitle)->
      @save title: newTitle
