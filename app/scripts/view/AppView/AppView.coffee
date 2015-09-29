define ['backbone', 'todoCollection', 'todoFilteredCollection', 'todoListView'],
(Backbone, TodoCollection, TodoFilteredCollection, TodoListView)->
  AppView = Backbone.View.extend
    className: 'app-block'

    #  REVIEW: а зачем использовать _.template если ты не используешь подстановку переменных?
    template: _.template @$('#app').html()

    # REVIEW: очень похоже на то, что ты хотела использовать модель, но забыла об этом
    filters:
      title: ''
      done: 'all'

    # REVIEW: все указанные здесь функции обработчики событий, но по их названиям это не понять
    events:
      'click [data-js-todo-add-submit]': 'addItem'
      'keypress [data-js-todo-add-title]': 'addItemOnEnter'
      'input [data-js-todo-filter-title]': 'setTitleFilter'
      'change [data-js-todo-filter-done]': 'setDoneFilter'

    initialize: ->
      @collection = new TodoCollection()
      @filteredCollection = new TodoFilteredCollection null, originalCollection: @collection

    render: ->
      @$el.html @template()
      @todoListView = new TodoListView {collection: @filteredCollection}
      @$el.find('[data-js-todo-list]').append @todoListView.render().$el
      this

    # REVIEW:  было бы круто очищать поле ввода
    addItem: ->
      @collection.addNewItem title: @$el.find('[data-js-todo-add-title]').val()

    addItemOnEnter: (e)->
      # REVIEW: такое круче записывать в одну строку, вот так:
      # @addItem() if (e.keyCode == 13)
      if (e.keyCode == 13)
        @addItem()

    setTitleFilter: (e) ->
      @filteredCollection.setTitleFilter $(e.target).val()

    setDoneFilter: (e) ->
      @filteredCollection.setDoneFilter $(e.target).val()


