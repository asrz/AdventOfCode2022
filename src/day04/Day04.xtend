package day04; 

import java.io.FileReader
import static extension com.google.common.io.CharStreams.*
import java.util.List
import static extension util.Extensions.*
import java.util.regex.Pattern

class Day04 {
	def static part1(List<List<Integer>> ranges) {
		val result = ranges.filter[containsOther]
			.size
		
		println(result)
	}
	
	def static part2(List<List<Integer>> ranges) {
		val result = ranges.filter[overlapsOther]
			.size
			
		println(result)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day04.in").readLines
		val Pattern pattern = Pattern.compile("(\\d+)-(\\d+),(\\d+)-(\\d+)")
		val ranges = lines.map[ line | pattern.matcher(line).groups ]
			.map[ list | list.map[s | Integer.parseInt(s)] ]
		
		part1(ranges)
		part2(ranges)
	}
	
	def static containsOther(List<Integer> list) {
		val a = list.get(0) <= list.get(2)
		val b = list.get(1) >= list.get(3)
		val c = list.get(0) >= list.get(2)
		val d = list.get(1) <= list.get(3)
		return (a && b) || (c && d) 
	}
	
	def static overlapsOther(List<Integer> list) {
		val a = list.get(0)
		val b = list.get(1)
		val c = list.get(2)
		val d = list.get(3)
		
		return !((b < c) || a > d)
	}
}
