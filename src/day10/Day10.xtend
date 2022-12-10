package day10;

import java.io.FileReader
import java.util.ArrayList
import java.util.List

import static extension com.google.common.io.CharStreams.*

class Day10 {
	val static List<Integer> importantCycles = new ArrayList
	
	def static cycleCheck(int cycle, int x) {
		if (cycle % 40 == 20) {
			importantCycles.add(cycle * x)
		}
	}
	
	def static draw(int cycle, int x) {
		if (cycle % 40 == 1) {
			println()
		}
		if (Math.abs((x+1) - (cycle%40)) < 2) {
			print("#")
		} else {
			print(".")
		}
		
	}
	
	def static part1(List<String> lines) {
		var cycle = 1
		var x = 1
		for (parts : lines.map[split(" ")]) {
			if (parts.get(0) == "noop") {
				cycle++
				cycleCheck(cycle, x)
			} else if (parts.get(0) == "addx") {
				val int operand = Integer.parseInt(parts.get(1))
				cycle++
				cycleCheck(cycle, x)
				cycle++
				x += operand
				cycleCheck(cycle, x)
			}
		}
		
		println(importantCycles.reduce[a,b|a+b])
	}
	
	def static part2(List<String> lines) {
		var cycle = 1
		var x = 1
		for (parts : lines.map[split(" ")]) {
			if (parts.get(0) == "noop") {
				draw(cycle, x)
				cycle++
			} else if (parts.get(0) == "addx") {
				val int operand = Integer.parseInt(parts.get(1))
				draw(cycle, x)
				cycle++
				draw(cycle, x)
				cycle++
				x += operand
			}
		}
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day10.in").readLines
		
		part1(lines)
		part2(lines)
	}
}
