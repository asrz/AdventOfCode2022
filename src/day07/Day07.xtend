package day07;

import java.io.FileReader
import java.util.ArrayList

import static extension com.google.common.io.CharStreams.*

class Day07 {
	def static void main(String[] args) {
		var Directory root = new Directory("/", null)
		var Directory activeDir
		
		val splitLines = new FileReader("day07.in").readLines.map[split(" ")]
		for (String[] parts : splitLines) {
			if (parts.get(0) == "$") {
				if (parts.get(1) == "cd") {
					if (parts.get(2) == "..") {
						activeDir = activeDir.parent
					} else if (parts.get(2) == "/") {
						activeDir = root
					} else {
						activeDir = activeDir.childDirectories.findFirst[dir | dir.name == parts.get(2)]
					}
				} else if (parts.get(1) == "ls") {
					
				}
			} else {
				val fileObject = FileObject.fromString(parts.join(" "), activeDir)
				activeDir.contents.add(fileObject)
			}
		}
		
//		root.print(0)
		
		val allDirectories = new ArrayList
		val queue = new ArrayList()
		queue.add(root)
		activeDir = null
		while (!queue.empty) {
			activeDir = queue.remove(0)
			queue.addAll(activeDir.childDirectories)
			allDirectories.add(activeDir)
		}
		
		//part 1
		println(allDirectories.filter[size < 100_000].map[size].reduce[a,b|a+b])
		
		val target = 30_000_000 - (70_000_000 - root.size)
		
		//part 2
		println(allDirectories.filter[size >= target].map[size].min)
	}
}
