package day02;

import java.io.FileReader
import static extension com.google.common.io.CharStreams.*
import java.util.List
import static extension util.Extensions.*
import java.util.Set

class Day02 {
	def static part1(List<String> lines) {
		val score = lines.map[ line | line.split(' ').toList ]
		.map[ symbolList | symbolList.map[symbol | Shape.fromString(symbol) ]]
		.map[ match | Shape.getMatchScore(match.get(0), match.get(1)) ]
		.reduce[ a, b | a+b ]
		
		println(score)
	}
	
	def static part2(List<String> lines) {
		val score = lines.map[ line | line.split(' ') ]
		.map[ array | Shape.fromString(array.get(0)) -> Result.fromString(array.get(1)) ]
		.map[ pair | pair.key -> Result.getShape(pair.key, pair.value) ]
		.map[ pair | Shape.getMatchScore(pair.key, pair.value) ]
		.reduce[ a,b | a+b ]
		
		println(score)
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day02.in").readLines
		
		part1(lines)
		part2(lines)
	}
	
}