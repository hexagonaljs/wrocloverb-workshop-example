#= require jquery
#= require underscore
#= require YouAreDaBomb
#= require YouAreDaBomb.shortcuts

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

  showNameForm: ->
    name = prompt("What's your name?")
    @nameFormSubmitted(name)

  nameFormSubmitted: (name) ->

  showGreeting: (name) ->
    alert("Hello, #{name}")

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

