define (require, exports, module) ->
  TodoModel = require 'model/TodoModel'
  describe 'TodoModel', ->
    beforeEach ->
      @todoModel = new TodoModel
      @todoModel.urlRoot = 'todolist-backbone'

    afterEach ->
      @todoModel.destroy()

    it 'should set attributes to default', ->
      expect(@todoModel).toBeDefined()
      expect(@todoModel.get 'title').toEqual ''
      expect(@todoModel.get 'done').toBeFalsy()

    it 'should correctly toggle', ->
      prevDone = @todoModel.get 'done'
      @todoModel.toggle()
      expect(@todoModel.get 'done').toEqual not prevDone

    it 'should correctly change title', ->
      @todoModel.changeTitle 'New title'
      expect(@todoModel.get 'title').toEqual 'New title'

    it 'should not save when title is empty', ->
      eventSpy = sinon.spy()
      @todoModel.listenTo @todoModel, 'invalid', eventSpy
      @todoModel.save {'title': ''}
      expect(eventSpy.calledOnce).toBeTruthy()
      expect(eventSpy.calledWith @todoModel, 'cannot have an empty title')
        .toBeTruthy()
