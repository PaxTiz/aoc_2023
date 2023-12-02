import strutils
import nre

proc parseTextToNumber(text: string): string =
  case text:
    of "one": return "1"
    of "two": return "2"
    of "three": return "3"
    of "four": return "4"
    of "five": return "5"
    of "six": return "6"
    of "seven": return "7"
    of "eight": return "8"
    of "nine": return "9"

    of "twone": return "21"
    of "eighthree": return "83"
    of "sevenine": return "79"
    of "oneight": return "18"
    of "nineight": return "98"
    of "fiveight": return "58"
    of "threeight": return "38"
    else: return text

proc parseInput(): seq[string] =
  let file = "./inputs/1.txt"
  let handle = file.open()

  result = handle.readAll().splitLines()
  handle.close()

proc part1*(): int =
  let lines = parseInput()

  var counter = 0
  for line in lines:
    let digits = line.findAll(re"\d")
    if digits.len == 0:
      echo "Error: No digit found in string" & line
      break

    let firstDigit = digits[0]
    if digits.len == 1:
      counter += parseInt(firstDigit & firstDigit)
    else:
      let lastDigit = digits[digits.len - 1]
      counter += parseInt(firstDigit & lastDigit)

proc part2*(): int =
  let lines = parseInput()
  
  var counter = 0
  for line in lines:
    let digits = line.findAll(re"(\d|threeight|fiveight|nineight|eighthree|sevenine|oneight|twone|one|two|three|four|five|six|seven|eight|nine)")
    if digits.len == 0:
      echo "Error: No digit found in string" & line
      break

    echo digits
    let firstDigit = parseTextToNumber(digits[0])
    var lastDigit = "."
    if digits.len == 1:
      counter += parseInt(firstDigit & firstDigit)
    else:
      lastDigit = parseTextToNumber(digits[digits.len - 1])
      counter += parseInt(firstDigit & lastDigit)

  return counter
