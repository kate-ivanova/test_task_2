define (require, exports, module) ->
  TodoCollection = require 'collection/TodoCollection'
  AddTodoWidget = require 'view/widget/AddTodoWidget/AddTodoWidget'

  describe 'AddTodoWidget', ->

    beforeEach ->
      @view = new AddTodoWidget {collection: new TodoCollection}
      @view.render()

    afterEach ->
      delete @view

    it 'should be defined', ->
      expect(@view).toBeDefined()

    it 'renders div.add-todo-widget', ->
      expect(@view.$el.hasClass 'add-todo-widget').toBeTruthy()

    it 'should bind jquery elements to ui', ->
      expect(@view.ui).toBeDefined()
      _.each @view.ui, (value) ->
        expect(value.length).toBeGreaterThan 0

    it 'should call @collection.add on addButton click', ->
      eventSpy = sinon.spy @view.collection, 'add'
      title = 'Test title'
      @view.ui.title.val title
      @view.ui.addButton.trigger 'click'
      expect(eventSpy.calledOnce)
      expect(eventSpy.calledWith {title: title}).toBeTruthy()

    it 'should call @collection.add on enter click', ->
      eventSpy = sinon.spy @view.collection, 'add'
      title = 'Test title'
      @view.ui.title.val title
      enterEvent = jQuery.Event 'keydown', {keyCode: 13}
      @view.ui.title.trigger enterEvent
      expect(eventSpy.calledOnce)
      expect(eventSpy.calledWith {title: title}).toBeTruthy()
