import strutils
import sequtils

type Ranges = (int, int, int)
type Numbers = seq[seq[Ranges]]

proc parseInput(): seq[string] =
  let file = "./inputs/5.txt"
  let handle = file.open()

  result = handle.readAll().splitLines()
  handle.close()

proc part1*(): int =
    let input = parseInput()
    let seeds = input[0].split(": ")[1].splitWhitespace().mapIt(parseInt(it))
    
    var parsedResults: Numbers = @[]
    var wasNewline = true
    var currentArray = newSeq[Ranges]()
    for lineIndex in 1 .. input.len - 1:
        let line = input[lineIndex]
        if lineIndex == input.len - 1:
            let currentLineNumbers = line.splitWhitespace().mapIt(parseInt(it))
            currentArray.add((currentLineNumbers[0], currentLineNumbers[1], currentLineNumbers[2]))
            parsedResults.add(currentArray)

        if line == "\n" or line.len == 0:
            parsedResults.add(currentArray)
            currentArray = @[]
            wasNewline = true
            continue

        if wasNewline:
            wasNewline = false
            continue

        let currentLineNumbers = line.splitWhitespace().mapIt(parseInt(it))
        currentArray.add((currentLineNumbers[0], currentLineNumbers[1], currentLineNumbers[2]))

    result = high(int)
    for seed in seeds:
        var currentIndex = seed
        for values in parsedResults:
            for items in values:
                if currentIndex >= items[1] and currentIndex <= items[1] + items[2]:
                    let position = (items[1] + items[2]) - currentIndex
                    currentIndex = (items[0] + items[2]) - position
                    break

        result = min(result, currentIndex)

proc part2*(): int =
    return 0
