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

useCase = new UseCase()
useCase.start()
useCase.nameProvided("name")
useCase.restart("name")
useCase.nameProvided("name")
