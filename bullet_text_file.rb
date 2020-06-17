array = [
	{:id=>1, :title=>"heading1", :heading_level=>0}, 
	{:id=>2, :title=>"heading2", :heading_level=>2}, 
	{:id=>3, :title=>"heading3", :heading_level=>1}, 
	{:id=>4, :title=>"heading4", :heading_level=>1}
]
@previous = array.shift
@previous[:s_no] = [1]
def previous
	@previous
end
def increment_serial_number(level)
	last_index_value = level.last
	level[-1] = last_index_value + 1
	level
end
def generate_new_serial_number(new_heading_level)
	level = (0..(new_heading_level)).map{|index| previous[:s_no][index] || 1}
	level = increment_serial_number(level) if previous[:heading_level] > new_heading_level
	level
end
def serial_number(record)
	s_no = if previous[:heading_level] == record[:heading_level]
					increment_serial_number(previous[:s_no])
				else
					generate_new_serial_number(record[:heading_level])
				end
	@previous = record.merge(s_no: s_no)
	s_no
end
def print_hash(heading_level, s_number, title)
	puts "\t " * heading_level + "#{s_number.join(".")}.  " + title
end
print_hash(@previous[:heading_level], @previous[:s_no], @previous[:title])
array.each {|input_hash| print_hash(input_hash[:heading_level], serial_number(input_hash), input_hash[:title])}