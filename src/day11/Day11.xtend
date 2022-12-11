package day11;

import java.io.FileReader
import java.math.BigInteger
import java.util.ArrayList
import java.util.List
import java.util.function.Function
import org.eclipse.xtend.lib.annotations.Accessors

import static extension com.google.common.io.CharStreams.*
import static extension util.Extensions.*

class Day11 {
	@Accessors
	static class Monkey {
		Integer id
		List<BigInteger> items = new ArrayList
		Function<BigInteger, BigInteger> operation
		BigInteger divisor
		Integer trueMonkey
		Integer falseMonkey
		BigInteger inspections = 0BI
		
	}
	
	def static parseMonkeys(List<String> lines) {
		val List<Monkey> monkeys = new ArrayList
		var Monkey activeMonkey = null
		for (line : lines.map[strip]) {
			if (line.startsWith("Monkey")) {
				activeMonkey = new Monkey
				activeMonkey.id = Integer.parseInt(line.slice(7,-1))
			} else if (line.startsWith("Starting items:")) {
				activeMonkey.items.addAll(line.slice("Starting items:".length).split(",").map[i | new BigInteger(i.strip)])
			} else if (line.startsWith("Operation: new = ")) {
				val parts = line.slice("Operation: new = ".length).split(" ")
				val operator = parts.get(1)
				if (parts.get(2) == "old") {
					activeMonkey.operation = switch(operator) {
						case "+": [old | old + old]
						case "*": [old | old * old]
					}
				} else {
					val operand = new BigInteger(parts.get(2))
					activeMonkey.operation = switch(operator) {
						case "+": [old | old + operand]
						case "*": [old | old * operand]
					}
				}
			} else if (line.startsWith("Test: divisible by ")) {
				activeMonkey.divisor = new BigInteger(line.slice("Test: divisible by ".length))
			} else if (line.startsWith("If true: throw to monkey ")) {
				activeMonkey.trueMonkey = Integer.parseInt(line.slice("If true: throw to monkey ".length)) 
			} else if (line.startsWith("If false: throw to monkey ")) {
				activeMonkey.falseMonkey = Integer.parseInt(line.slice("If false: throw to monkey ".length))
				monkeys.add(activeMonkey)
			}
		}
		
		return monkeys
	}
	
	def static processMonkeys(List<Monkey> monkeys, int rounds, Function<BigInteger, BigInteger> reducer) {
		for(round : 1..rounds) {
			for (monkey : monkeys) {
				for (item : monkey.items) {
					val worryLevel = reducer.apply(monkey.operation.apply(item))
					val monkeyId = if (worryLevel % monkey.divisor == 0BI) {
						monkey.trueMonkey
					} else {
						monkey.falseMonkey
					}
					monkeys.get(monkeyId).items.add(worryLevel)
				}
				monkey.inspections = monkey.inspections + BigInteger.valueOf(monkey.items.size)
				monkey.items.clear
			}
		}

		println(monkeys.map[inspections].sort.reverse.take(2).reduce[a,b|a*b])
	}
	
	def static void main(String[] args) {
		val lines = new FileReader("day11.in").readLines
		
		//part 1
		var monkeys = parseMonkeys(lines)
		processMonkeys(monkeys, 20, [worry | worry / 3BI])
		
		//part 2
		monkeys = parseMonkeys(lines)
		val lcm = monkeys.map[divisor].reduce[a,b|a*b]
		processMonkeys(monkeys, 10000, [worry | worry % lcm])
	}
}
