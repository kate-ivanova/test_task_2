define (require, exports, module) ->
  Backbone = require 'backbone'
  _Page = require '../_Page'
  require 'backbone.epoxy'

  NotFoundPage = _Page.extend
    className: 'not-found-block'

    template: $('#NotFoundPage').html()

    initialize: -> @$el.html @template
