{Game} = require '../src/game'
{Player} = require '../src/player'
NoLimit = require '../src/betting/no_limit'

randBot = require './players/unpredictable'
smartBot = require './players/smart_bot'

Minimist = require 'minimist'

noLimit = new NoLimit(10,20)
players = []
chips = 1000

players.push new Player(randBot(), chips, "Jim")
players.push new Player(smartBot(), chips, "Sam")

argv = Minimist(process.argv)

run = (game) ->
  game.run()
  game.on 'roundComplete', ->
    console.log "round complete"
  game.on 'complete', (status) ->
    console.log players.map (p) -> "Name: #{p.name} - $#{p.chips}"


#game = new Game(players, noLimit, 1, {async: true})
game = new Game(players, noLimit)
str = JSON.stringify(game, null, 4)
#console.log(str)
game2 = new Game(players, noLimit)
game2.load(JSON.parse(str))
game2.players[0].bot = randBot()
game2.players[1].bot = smartBot()
run(game2)