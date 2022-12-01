package day01

import java.io.FileReader
import static extension com.google.common.io.CharStreams.*
import java.util.List
import static extension util.Extensions.*

class Day01 {
	
	def static part1(List<String> lines) {
//		println(lines.reSplit("\\s*").map[ subList | subList.map[ calories | Integer.parseInt(calories) ].reduce[a,b | a+b]].max)
		var int maxCalories = 0
		var int calories = 0
		for (line : lines) {
			if (line.isBlank) {
				maxCalories = Math.max(maxCalories, calories)
				calories = 0
			} else {
				calories += Integer.parseInt(line)
			}
		}
		
		println(maxCalories)
	}
	
	def static part2(List<String> lines) {
		println(lines.reSplit("\\s*").map[ subList | subList.map [ element | Integer.parseInt(element) ].reduce[a,b | a+b] ].sort.reverse.subList(0,3).reduce[a,b | a+b])
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day01.in").readLines
		
		part1(lines)
		part2(lines)
	}
	
}