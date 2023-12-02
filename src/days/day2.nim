import strutils
import sequtils

type Cubes = object
    red: int = 0
    green: int = 0
    blue: int = 0
        
type Game = object
    id: int
    groups: seq[Cubes]

proc toCubes(value: string): Cubes =
    let values = value.split(",")
    for element in values:
        let elements = element.strip().split(" ")
        let quantity = parseInt(elements[0])
        let color = elements[1]

        if color == "red":
            result.red = quantity
        elif color == "blue":  
            result.blue = quantity
        else:
            result.green = quantity

proc parseGames(lines: seq[string]): seq[Game] =
    var games = newSeq[Game]()

    for line in lines:
        let items = line.split(": ")
        let id = parseInt(items[0].split(" ")[1])

        let groups = items[1].split(";").mapIt(toCubes(it))
        games.add(Game(id: id, groups: groups))

    return games

proc parseInput(): seq[string] =
    let file = "./inputs/2.txt"
    let handle = file.open()

    result = handle.readAll().splitLines()
    handle.close()

proc part1*(): int =
    let games = parseInput().parseGames()

    var counter = 0
    for game in games:
        if game.groups.allIt(it.red <= 12 and it.blue <= 14 and it.green <= 13):
            counter += game.id

    return counter

proc part2*(): int =
    let games = parseInput().parseGames()

    var counter = 0
    for game in games:
        let red = game.groups.mapIt(it.red).max()
        let green = game.groups.mapIt(it.green).max()
        let blue = game.groups.mapIt(it.blue).max()

        counter += red * green * blue

    return counter
