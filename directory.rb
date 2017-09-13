def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    #get another name from the user
    name = gets.chomp
  end
  #returns the students array
  students
#   # Asking if they want to filter the names by the first letter
#   puts "Do you want to see the students with a name that starts with a specific letter?"
#   puts "Please respond Yes or No."
#   user_response = gets.chomp
#
#   while (user_response.downcase.match(/^[yes|no]+$/)) == nil do
#     puts "Your response was #{user_response}"
#     puts "Please answer Yes or No. No other resonse is accepted"
#     puts user_response.downcase.chomp =~ /ys\b|no/
#     user_response = gets.chomp
#   end
#
#   return students if user_response.downcase == "no"
#
#   puts "Which letter?" if user_response.downcase == "yes"
#
#   letter = gets.chomp
#
#   while (letter.length != 1 || letter[/[a-z]|[A-Z]/] == nil) do
#     puts "Only ONE letter of the ALPHABET is accepted "
#     puts "No other character is allowed "
#     letter = gets.chomp
# end
#
# students.select{ |x| x[:name][0].downcase == letter.downcase}

students
end
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  # students.map{|item| item.values}.flatten.select do |name|
  # #if name.to_s.chars.first == "A"
  # if name.length < 12 && name != :november
  # puts name
  # end
students.each.with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
#
# count_student = students.length
# index = 0
# while count_student > 0
#   newIndex = "#{index}".to_i
#   puts "#{index+1}. #{students[newIndex][:name]} (#{students[newIndex][:cohort]} cohort)"
#   count_student -= 1
#   index += 1
# end

end

def print_footer(students)
 puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
