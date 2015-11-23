define (require, exports, module) ->
  TodoItemView = require 'view/list/TodoItemView/TodoItemView'


  describe 'TodoItemView', ->
    # jasmine.getFixtures().fixturesPath = '/base/scripts/view/list/TodoItemView/'
    # loadFixtures('TodoItemView.html')
    beforeAll ->
      jasmine.getFixtures().fixturesPath = '/base/app/scripts'
      fxtrs = readFixtures 'view/list/TodoItemView/TodoItemView.html'
      console.log fxtrs
    beforeEach ->
      # TodoModel stub
      @todoModelStub = sinon.stub()
      @model = new Backbone.Model
        title: ''
        done: false
      @todoModelStub.returns @model
      # TodoItemView
      @view = new TodoItemView {model: new @todoModelStub}
    it 'should be defined', ->
      expect(@view).toBeDefined()
    it 'should correctly handle edit click', ->
      @view.ui.buttonEdit.click()
      expect(@view.ui.title).toHaveClass('hidden')
      expect(@view.ui.editTitleInput).not.toHaveClass('hidden')
