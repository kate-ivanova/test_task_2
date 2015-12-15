define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  $ = Backbone.$

  _Page = Backbone.Epoxy.View.extend
    display: (display)-> @$el.toggleClass 'hide', !display



