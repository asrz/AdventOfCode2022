package day07

import day07.FileObject
import org.eclipse.xtend.lib.annotations.Data

@Data
class File extends FileObject {
	
	Long size
	String name
	
	new(Long size, String name, Directory parent) {
		this.size = size
		this.name = name
		this.parent = parent
	}
	
	override void print(int indent) {
		var String line = " ".repeat(indent)
			+ "- " + name + " (file, size=" + size + ")"
		println(line)
	}
}