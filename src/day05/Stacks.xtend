package day05

import day05.Day05.Instruction
import java.util.ArrayList
import java.util.List

class Stacks {
	List<List<String>> rows
	
	new(List<List<String>> rows) {
		this.rows = new ArrayList;
		rows.forEach[ row | this.rows.add(new ArrayList(row))]
		this.rows.forEach[ row | row.add("")]
	}
	
	def size() {
		return rows.get(0).size
	}
	
	def move9000(Instruction instruction) {
		(0..<instruction.amount).forEach[move(instruction.from-1, instruction.to-1)]
	}
	
	def move9001(Instruction instruction) {
		(0..<instruction.amount).forEach[ _ |
			move(instruction.from-1, size-1)
		]
		(0..<instruction.amount).forEach[ _ |
			move(size-1, instruction.to-1)
		]
	}
	
	def move(int from, int to) {
		val crate = remove(from)
		add(to, crate)
	}
	
	def add(int column, String crate) {
		var lastEmpty = rows.findLast[row | row.get(column) == ""]
		if (lastEmpty === null) {
			lastEmpty = newArrayList
			for (i : 0..<size) {
				lastEmpty.add("")
			}
			rows.add(0, lastEmpty)
		}
		lastEmpty.set(column, crate)
	}
	
	def remove(int column) {
		val topRow = rows.findFirst[ row | 
			row.get(column) != ""
		]
		
		val crate = topRow.get(column)
		topRow.set(column, "")
		
		return crate
	}
	
	def print() {
		rows.forEach[row | println(row)]
		println()
	}
	
	def top() {
		return (0..< size).map[ column | 
			rows.findFirst[ row | row.get(column) != "" ]?.get(column) ?: "[ ]"
		].map[ s | s.substring(1,2) ]
		.join
	}
	
}