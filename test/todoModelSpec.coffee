define (require, exports, module) ->
  TodoModel = require('app/scripts/model/TodoModel')
  describe 'TodoModel testing', ()->
    todoModel = new TodoModel()
    it 'initial state', ()->
      (expect todoModel.attributes).toEqual {title: 'Новая задача', done: false}
    it 'toggle', ()->
      prevDone = todoModel.get 'done'
      todoModel.toggle()
      done = todoModel.get 'done'
      (expect prevDone).toEqual not done
    it 'change title', ()->
      todoModel.changeTitle 'New title'
      newTitle = todoModel.get 'title'
      (expect newTitle).toEqual 'New title'
