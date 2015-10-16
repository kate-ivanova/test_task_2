define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'

  NotFoundPage = Backbone.Epoxy.View.extend
    className: 'not-found-block'

    template: $('#NotFoundPage').html()

    initialize: -> @$el.html @template

    hide: ->
      @$el.toggleClass 'hide', true

    show: ->
      @$el.toggleClass 'hide', false
