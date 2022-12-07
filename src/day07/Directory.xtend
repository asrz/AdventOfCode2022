package day07

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Directory extends FileObject {
	
	String name
	List<FileObject> contents = new ArrayList
	
	new (String name, Directory parent) {
		this.name = name
		this.parent = parent
	}
	
	override Long getSize() {
		return contents.map[size].reduce[a,b|a+b]
	}
	
	override void print(int indent) {
		var String result = " ".repeat(indent)
			+ "- " + name + " (dir)"
		println(result)
		contents.forEach[print(indent+2)]
	}
	
	def Directory[] getChildDirectories() {
		return contents.filter[child | child instanceof Directory].map[child | child as Directory]
	}
}