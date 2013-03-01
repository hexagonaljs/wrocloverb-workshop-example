#= require jquery
#= require handlebars
#= require underscore
#= require YouAreDaBomb
#= require YouAreDaBomb.shortcuts
#= require_tree ./templates

class UseCase
  constructor: ->

  start: =>
    @askForName()

  askForName: =>

  nameProvided: (name) =>
    @greetUser(name)

  greetUser: (name) =>

  restart: =>
    @askForName()








class Gui
  constructor: ->
    @container = $("body")

  showNameForm: ->
    html = JST['templates/name_form']
    @container.append(html)
    form = @container.find("#name-form")
    form.submit (e) =>
      e.preventDefault()
      name = form.find("input[name='name']").val()
      @nameFormSubmitted(name)

  removeNameForm: ->
    @container.find("#name-form").detach()

  nameFormSubmitted: (name) ->

  showGreeting: (name) ->
    @removeNameForm()
    html = JST['templates/greeting'](name: name)
    @container.append(html)

  removeGreeting: ->
    @container.find("#greeting").detach()

  showRestartButton: ->
    button = $("<input type='button' value='restart'>")
    $("body").append(button)
    button.click (e) =>
      e.preventDefault()
      @restartClicked()

  restartClicked: ->







class Glue
  constructor: (@useCase, @gui) ->
    Before(@useCase, 'start', =>
      @gui.showRestartButton()
    )
    After(@useCase, 'askForName', =>
      @gui.showNameForm()
    )
    After(@gui, 'nameFormSubmitted', (name) =>
      @useCase.nameProvided(name)
    )
    After(@useCase, 'greetUser', (name) =>
      @gui.showGreeting(name)
    )
    After(@gui, 'restartClicked', (name) =>
      @useCase.restart()
    )
    Before(@useCase, 'restart', =>
      @gui.removeGreeting()
    )









class App
  constructor: ->
    @setupDomain()
    @setupGui()
    @setupGlue()

  setupDomain: =>
    @useCase = new UseCase()

  setupGui: =>
    @gui = new Gui()

  setupGlue: =>
    @glue = new Glue(@useCase, @gui)

  start: ->
    @useCase.start()


$ ->
  app = new App()
  app.start()

