define (require, exports, module) ->
  TodoItemPage = require 'view/page/TodoItemPage/TodoItemPage'
  TodoModel = require 'model/TodoModel'

  describe 'TodoItemPage', ->

    beforeEach ->
      @view = new TodoItemPage(new TodoModel)

    afterEach ->
      delete @view

    it 'should be defined', ->
      expect(@view).toBeDefined()

    it 'should enter edit mode on edit button click', ->
      @view.ui.buttonEdit.trigger 'click'
      expect(@view.$el.hasClass 'todo-item__edit').toBeTruthy()

    it 'should save edited title on save button click and out edit mode', ->
      @view.ui.buttonEdit.trigger 'click'
      newTitle = (@view.model.get 'title') + 'New title'
      @view.ui.editTitle.val newTitle
      @view.ui.buttonSave.trigger 'click'
      expect(@view.model.get 'title').toBe newTitle
      expect(@view.$el.hasClass 'todo-item__edit').toBeFalsy()

    it 'should save edited title on enter keydown and out edit mode', ->
      @view.ui.buttonEdit.trigger 'click'
      newTitle = (@view.model.get 'title') + 'New title'
      @view.ui.editTitle.val newTitle
      enterEvent = jQuery.Event 'keydown', {keyCode: 13}
      @view.ui.editTitle.trigger enterEvent
      expect(@view.model.get 'title').toBe newTitle
      expect(@view.$el.hasClass 'todo-item__edit').toBeFalsy()

    it 'should cancel edited title on cancel click and out edit mode', ->
      @view.ui.buttonEdit.trigger 'click'
      oldTitle = @view.model.get 'title'
      @view.ui.editTitle.val(oldTitle + 'New title')
      @view.ui.buttonCancel.trigger 'click'
      expect(@view.model.get 'title').toBe oldTitle
      expect(@view.$el.hasClass 'todo-item__edit').toBeFalsy()



