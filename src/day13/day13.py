def compare(left, right):
	if isinstance(left, list) and isinstance(right, list):
		for i in range(min(len(left), len(right))):
			c = compare(left[i], right[i])
			if c != 0:
				return c
				
		return len(right) - len(left)
	elif isinstance(left, list) and isinstance(right, int):
		return compare(left, [right])
	elif isinstance(left, int) and isinstance(right, list):
		return compare([left], right)
	elif isinstance(left, int) and isinstance(right, int):
		return right - left
	else:
		print(type(left), type(right))
		
	
def part1(lines):
	total = 0

	for i in range(1, len(lines), 2):
		left = lines[i-1]
		right = lines[i]
		
		c = compare(left, right)
		if c > 0:
			total += (i+1)//2
		
	print(total)


def part2(lines):
	packets = [lines[0]]
	
	lines.append([[2]])
	lines.append([[6]])
	
	for line in lines[1:]:
		inserted = False
		for i in range(len(packets)):
			c = compare(line, packets[i])
			if c > 0:
				packets.insert(i, line)
				inserted = True
				break
		if not inserted:
			packets.append(line)
		
	
	i = packets.index([[2]]) + 1
	j = packets.index([[6]]) + 1
	print(i*j)
		
		
	

lines = []

with open('../../day13.in', 'r') as input_file:
	for line in input_file:
		if len(line.strip()) > 0:
			lines.append(eval(line[:-1]))

part1(lines)
part2(lines)

	
	
