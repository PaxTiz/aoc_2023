import strutils
import sequtils
import tables
import options
import re

type Identifier = tuple
    id: int
    first: int
    last: int

proc parseInput(): (string, int) =
    let file = "./inputs/3.txt"
    let handle = file.open()

    let baseInput = handle.readAll()
    handle.close()

    let lineLength = baseInput.find('\n')
    let input = baseInput.replace("\n", "")

    return (input, lineLength)

proc generatePositions(first: int, last: int, lineLength: int, inputLength: int): seq[int] =
    let length = (last - first) + 1
    var positions = @[
        first - 1, # left
        first - 1 - lineLength, # top left bound
        last + 1, # right
        last + 1 + lineLength, # bottom right bound
    ]

    for i in 0..length + 1:
        positions.add(first - 1 - lineLength + i) # Up line
        positions.add(last + 1 + lineLength - i) # Down line

    return positions.filterIt(it >= 0 and it <= inputLength - 1).deduplicate()

proc getIndentifer(input: string, start: int): Option[Identifier] =
    let (first, last) = input.findBounds(re"\d+", start = start)
    if first < 0:
        return none(Identifier)

    let identifier = parseInt(input.substr(first, last))
    return some((identifier, first, last))

proc part1*(): int =
    let (input, lineLength) = parseInput()

    var counter = 0
    var boundsStart = 0
    while true:
        let optionalResult = getIndentifer(input, boundsStart)
        if optionalResult.isNone:
            break

        let (id, first, last) = optionalResult.get()
        let positions = generatePositions(first, last, lineLength, input.len)
        for position in positions:
            let element = $input[position]
            if element != "." and not element.match(re"\d"):
                counter += id

        boundsStart = last + 1

    return counter

proc part2*(): int =
    let (input, lineLength) = parseInput()
    
    var starsToIds = initTable[int, seq[int]]()

    var counter = 0
    var boundsStart = 0
    while true:
        let optionalResult = getIndentifer(input, boundsStart)
        if optionalResult.isNone:
            break

        let (id, first, last) = optionalResult.get()
        let positions = generatePositions(first, last, lineLength, input.len)
        for position in positions:
            let element = $input[position]
            if element == "*":
                if not starsToIds.hasKey(position):
                    starsToIds[position] = @[]
    
                starsToIds[position].add(id)

        boundsStart = last + 1

    for (position, ids) in starsToIds.pairs():
        if ids.len == 2:
            counter += ids[0] * ids[1]

    return counter
