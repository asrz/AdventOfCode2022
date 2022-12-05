package day05;

import java.io.FileReader
import java.util.ArrayList
import java.util.List
import java.util.regex.Pattern
import org.eclipse.xtend.lib.annotations.Data

import static extension com.google.common.io.CharStreams.*
import static extension util.Extensions.*

class Day05 {
	def static part1(List<List<String>> rows, List<Instruction> instructions) {
		val Stacks stacks = new Stacks(rows)
		
		instructions.forEach[ instruction | 
			stacks.move9000(instruction)
		]
		
		println(stacks.top())
	}
	
	def static part2(List<List<String>> rows, List<Instruction> instructions) {
		val Stacks stacks = new Stacks(rows)
		
		instructions.forEach[ instruction | 
			stacks.move9001(instruction)
		]
		
		println(stacks.top())
	}
	
	def static void main(String[] args) {
		val Pattern stacksPattern = Pattern.compile("((\\s{3}|\\[\\w\\])\\s?)+")
		val Pattern labelsPattern = Pattern.compile("\\s*((\\d)\\s+)+")
		val Pattern instructionsPattern = Pattern.compile("move (\\d+) from (\\d+) to (\\d+)")
		
		val List<List<String>> rows = new ArrayList
		val List<Instruction> instructions = new ArrayList 
		
		new FileReader("day05.in").readLines
			.forEach[ line |
				val stacksMatcher = stacksPattern.matcher(line)
				val labelsMatcher = labelsPattern.matcher(line)
				val instructionsMatcher = instructionsPattern.matcher(line)
				if (stacksMatcher.matches) {
					rows.add(line.partition(4).map[strip])
				} else if (labelsMatcher.matches) {
					
				} else if (instructionsMatcher.matches) {
					instructions.add(new Instruction(instructionsMatcher.groups.map[s | Integer.parseInt(s)]))
				}
			]
			
//		println(rows)
//		println(instructions)
		
		part1(rows, instructions)
		part2(rows, instructions)
	}
	
	@Data static class Instruction {
		val int amount
		val int from
		val int to
		
		new(List<Integer> list) {
			amount = list.get(0)
			from = list.get(1)
			to = list.get(2)
		}
	}
}
