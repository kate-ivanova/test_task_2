define (require, exports, module) ->
  TodoItemView = require 'view/list/TodoItemView/TodoItemView'


  describe 'TodoItemView', ->
    beforeEach ->
      # TodoModel stub
      @todoModelStub = sinon.stub()
      @model = new Backbone.Model
        title: ''
        done: false
      @todoModelStub.returns @model
      # TodoItemView
      @view = new TodoItemView {model: new @todoModelStub}
      console.log @view.template
    it 'should be defined', ->
      expect(@view).toBeDefined()
    it 'should correctly handle edit click', ->
      @view.ui.buttonEdit.click()
      expect(@view.ui.title).toHaveClass('hidden')
      expect(@view.ui.editTitleInput).not.toHaveClass('hidden')
