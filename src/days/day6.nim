import strutils
import sequtils

type Race = tuple[time: int, distance: int]

proc parseInput(): seq[Race] =
  result = newSeq[Race]()
  let file = "./inputs/6.txt"
  let handle = file.open()

  let lines = handle.readAll().splitLines()
  handle.close()

  let timesLine = lines[0].split(" ")
  let times = timesLine[1..timesLine.len - 1].mapIt(it.strip()).filterIt(it.len > 0).mapIt(parseInt(it))

  let distancesLine = lines[1].split(" ")
  let distances = distancesLine[1..distancesLine.len - 1].mapIt(it.strip()).filterIt(it.len > 0).mapIt(parseInt(it))

  result = times.zip(distances)

proc part1*(): int =
    let races = parseInput()

    result = 1
    for race in races:
      let raceDuration = race.time
      let raceDistance = race.distance

      var possibilities = 0
      for i in 1..raceDuration:
        let distance = (raceDuration - i) * i
        if distance > raceDistance:
          possibilities += 1

      result *= possibilities

proc part2*(): int =
    let races = parseInput()

    let raceDuration = parseInt(races.mapIt(it.time).foldl($a & $b, ""))
    let raceDistance = parseInt(races.mapIt(it.distance).foldl($a & $b, ""))

    result = 0
    for i in 1..raceDuration:
      let distance = (raceDuration - i) * i
      if distance > raceDistance:
        result += 1
