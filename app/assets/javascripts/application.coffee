class UseCase
  constructor: ->

  start: =>
    @askForName()

  askForName: =>
    console.log("What's your name, sir")

  nameProvided: (name) =>
    @greetUser(name)

  greetUser: (name) =>
    console.log("Hello, #{name}")

  restart: =>
    @askForName()

useCase = new UseCase()
useCase.start()
useCase.nameProvided("John")
useCase.restart()
useCase.nameProvided("Jacob")
