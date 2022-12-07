package day07

import org.eclipse.xtend.lib.annotations.Accessors

abstract class FileObject {
	
	@Accessors
	Directory parent
	
	def static FileObject fromString(String command, Directory activeDir) {
		val parts = command.split(" ")
		if (parts.get(0) == "dir") {
			return new Directory(parts.get(1), activeDir)
		} else {
			return new File(Long.parseLong(parts.get(0)), parts.get(1), activeDir)
		}
	}
	
	def abstract String getName()
	
	def abstract Long getSize()
	
	def abstract void print(int indent)
}