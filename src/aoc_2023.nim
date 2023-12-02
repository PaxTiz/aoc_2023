import strutils
import days/day1
import days/day2

when isMainModule:
    echo "Part 1: " & intToStr(day2.part1())
    echo "Part 2: " & intToStr(day2.part2())
