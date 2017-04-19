{Game} = require '../src/game'
{Card} = require 'hoyle'
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
    numPlayer = (players.filter (p) -> p.chips > 0).length

game = new Game(players, noLimit, 1, {async: true})
str = JSON.stringify(game)
game2 = Game.fromJSON(JSON.parse(str))
run(game2)