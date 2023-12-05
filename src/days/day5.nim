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
    for lineIndex in 0 .. input.len - 1:
        if lineIndex <= 1:
            continue

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

    var results = newSeq[int]()
    for seed in seeds:
        var currentIndex = seed
        for values in parsedResults:
            for items in values:
                let sourceRange = (items[1]..(items[1] + items[2]) - 1).toSeq

                let position = sourceRange.find(currentIndex)
                if position != -1:
                    let destinationRange = (items[0]..(items[0] + items[2]) - 1).toSeq
                    currentIndex = destinationRange[position]
                    break

        results.add(currentIndex)

    return results.min()

proc part2*(): int =
    return 0
