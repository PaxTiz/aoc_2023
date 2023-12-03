import strutils
import sequtils
import tables
import re

proc parseInput(): string =
    let file = "./inputs/3.txt"
    let handle = file.open()

    result = handle.readAll()
    handle.close()

proc part1*(): int =
    let baseInput = parseInput()
    let lineLength = baseInput.find('\n')
    let input = baseInput.replace("\n", "")

    var counter = 0
    var boundsStart = 0
    while true:
        let (first, last) = input.findBounds(re"\d+", start = boundsStart)
        if first < 0:
            break

        let length = (last - first) + 1
        let identifier = parseInt(input.substr(first, last))

        var positions = @[
            first - 1, # left
            first - 1 - lineLength, # top left bound
            last + 1, # right
            last + 1 + lineLength, # bottom right bound
        ]

        for i in 0..length + 1:
            positions.add(first - 1 - lineLength + i) # Up line
            positions.add(last + 1 + lineLength - i) # Down line

        positions = positions.filterIt(it >= 0 and it <= input.len - 1).deduplicate()
        
        for position in positions:
            let element = $input[position]
            if element != "." and not element.match(re"\d"):
                counter += identifier

        boundsStart = last + 1

    return counter

proc part2*(): int =
    let baseInput = parseInput()
    let lineLength = baseInput.find('\n')
    let input = baseInput.replace("\n", "")

    var starsToIds = initTable[int, seq[int]]()

    var counter = 0
    var boundsStart = 0
    while true:
        let (first, last) = input.findBounds(re"\d+", start = boundsStart)
        if first < 0:
            break

        let length = (last - first) + 1
        let identifier = parseInt(input.substr(first, last))

        var positions = @[
            first - 1, # left
            first - 1 - lineLength, # top left bound
            last + 1, # right
            last + 1 + lineLength, # bottom right bound
        ]

        for i in 0..length + 1:
            positions.add(first - 1 - lineLength + i) # Up line
            positions.add(last + 1 + lineLength - i) # Down line

        positions = positions.filterIt(it >= 0 and it <= input.len - 1).deduplicate()
        
        for position in positions:
            let element = $input[position]
            if element == "*":
                if not starsToIds.hasKey(position):
                    starsToIds[position] = @[]
    
                starsToIds[position].add(identifier)

        boundsStart = last + 1

    for (position, ids) in starsToIds.pairs():
        if ids.len == 2:
            counter += ids[0] * ids[1]

    return counter
