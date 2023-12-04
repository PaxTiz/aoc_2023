import strutils
import sequtils
import nre

proc parseInput(): seq[string] =
  let file = "./inputs/4.txt"
  let handle = file.open()

  result = handle.readAll().splitLines()
  handle.close()

proc parseLineNumbers(line: string): seq[int] =
    return line.split(" ")
        .mapIt(it.strip())
        .filterIt(not it.isEmptyOrWhitespace)
        .mapIt(parseInt(it))

proc part1*(): int =
    let lines = parseInput()

    var counter = 0
    for line in lines:
        let matches = line.findAll(re"(?<winning>(\d+( ){0,2})+)|(?<input>(\d+( ){0,2})+)")

        let winning = parseLineNumbers(matches[1])
        let mine = parseLineNumbers(matches[2])

        let count = mine.countIt(winning.contains(it))
        
        if count > 0:
            counter += (1..count - 1).foldl(a * 2, 1)

    return counter

proc part2*(): int =
    return 0
