define (require, exports, module) ->
  TodoCollection = require('app/scripts/collection/TodoCollection')
  describe 'TodoCollection testing', ()->
    todoCollection = new TodoCollection()
    console.log todoCollection
