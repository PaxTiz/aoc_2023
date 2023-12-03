import strutils
import days/day1
import days/day2
import days/day3

when isMainModule:
    echo "Part 1: " & intToStr(day3.part1())
    echo "Part 2: " & intToStr(day3.part2())
