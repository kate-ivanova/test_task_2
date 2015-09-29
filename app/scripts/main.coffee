require.config
  paths:
    'jquery': '/bower_components/jquery/dist/jquery'
    'underscore': '/bower_components/underscore/underscore'
    'modernizr': '/bower_components/modernizr/modernizr'
    'backbone': '/bower_components/backbone/backbone'
    'backbone.localStorage': '/bower_components/backbone.localStorage/backbone.localStorage'
    # locals
    'todoModel': 'model/TodoModel'
    'todoCollection': 'collection/TodoCollection'
    'todoFilteredCollection': 'collection/TodoFilteredCollection'
    'todoItemView': 'view/TodoItemView/TodoItemView'
    'todoListView': 'view/TodoListView/TodoListView'
    'appView': 'view/AppView/AppView'

require ['backbone', 'appView', 'todoItemView'], (Backbone, AppView, TodoItemView)->
  appView = new AppView()

  appView.render()

  Router = Backbone.Router.extend
    currentRoute: null
    initialize: ->
      @on "route", @onChangeRoute, this

    onChangeRoute: (route)->
      @currentRoute = route

    routes:
      '': 'index'
      'items/:id': 'items'
      '*other': 'default'

    # REVIEW: это что за jquery-style? сколько раз на файле упомянается $('.content-block')[0]?
    index: ->
      $($('.content-block')[0]).html('')
      $($('.content-block')[0]).append(appView.$el)


    # REVIEW: что-то не понял, как из приложения попасть на такой роут
    items: (id)->
      # REVIEW: такоя проверка не канает, даже сейчас(она не работает, если что-то удалено)
      # REVIEW: лучше проверять реальный факт, а именно существование модели
      if(+id - 1 < appView.collection.models.length && +id)
        $($('.content-block')[0]).html('')
        # REVIEW: так искать модель тоже не стоит, для этого существуют специальные методы
        itemView = new TodoItemView model: appView.collection.models[+id - 1]
        $($('.content-block')[0]).append(itemView.render().$el)
      else
        $($('.content-block')[0]).html('Страница не найдена')

      # REVIEW: дублирование
      default: (other)->
        $($('.content-block')[0]).html('Страница не найдена')


  router = new Router()
  Backbone.history.start()


