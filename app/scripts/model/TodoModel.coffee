define (require, exports, module) ->
  Backbone = require 'backbone'

  TodoModel = Backbone.Model.extend
    defaults:
      title: ''
      done: false

    toggle: ->
      @set done: !@get 'done'

    validate: (attrs)->
      'cannot have an empty title' if not attrs.title
