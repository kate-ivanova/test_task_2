define ['backbone'], (Backbone)->
  #REVIEW: нет обработки на blur в режиме редактирования
  TodoItemView = Backbone.View.extend
    template: _.template @$('#todoItem').html()

    className: 'todo-item'

    events:
      'click [data-js-todo-delete]': 'destroy'
      'change [data-js-todo-done]': 'toggleDone'
      'click [data-js-todo-title]': 'showEditTitle'
      'keypress [data-js-todo-edit-title]': 'saveEditedTitleOnEnter'

    initialize: ->
      # REVIEW: ты же пишешь на coffee! нафиг скобки!
      @listenTo(@model, 'change', @render)
      @listenTo(@model, 'destroy', @remove)

    # REVIEW: здесь ничего не читается
    # REVIEW: поля класса ссылающиеся на jquery принято начинать c $
    # даже если бы не это правило тебе бы стоило как-то отразить в названии (например закончить на el)
    # правило универсальное и должно работать всега. называй переменные понятно
    # REVIEW: лучше выделить в отдельный метод инициализацию переменных и отображение данных из модели
    render: ->
      @$el.html @template(@model.attributes)
      @$el.addClass 'todo-item'
          .attr('data-js-todo-id', @model.get 'id')
      @done = @$el.find('[data-js-todo-done]')
      @done.prop('checked', @model.get 'done')
      @title = @$el.find('[data-js-todo-title]')
      @editTitle = @$el.find('[data-js-todo-edit-title]').val(@model.get 'title')
      @editTitle.addClass 'hidden'
      @title.removeClass 'hidden'
      this

    showEditTitle: ->
      @editTitle.removeClass 'hidden'
      @title.addClass 'hidden'

    saveEditedTitleOnEnter: (e)->
      if (e.keyCode == 13)
        @model.changeTitle @editTitle.val()

    # REVIEW: 3 метода снизу для компактности можно записывать в одну строку
    # toggleDone: (e)-> @model.toggle()
    toggleDone: (e)->
      @model.toggle()

    destroy: ->
      @model.destroy()

    remove: ->
      @$el.remove()
