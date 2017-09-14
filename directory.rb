  @students = []
  @letter = ""
  @user_response_final = ""

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #create an empty array

  #get the first name
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: :november}
    @students << {name: name, cohort: :november, hobbies: :coding, birthplace: :London, :height :tall}
    puts "Now we have #{@students.count} students"
    #get another name from the user
    name = gets.chomp
  end
  #returns the students array
  @students
  # Asking if they want to filter the names by the first letter
  puts "Do you want to see the students with a name that starts with a specific letter?"
  puts "Please respond Yes or No."
  user_response = gets.chomp

  while (user_response.downcase.match(/^[yes|no]+$/)) == nil do
    puts "Your response was #{user_response}"
    puts "Please answer Yes or No. No other resonse is accepted"
    puts user_response.downcase.chomp =~ /yes\b|no/
    @user_response_final = gets.chomp
  end

  return @students if @user_response_final.downcase == "no"

  puts "Which letter?" if @user_response_final.downcase == "yes"

  @letter = gets.chomp

  while (@letter.length != 1 || @letter[/[a-z]|[A-Z]/] == nil) do
    puts "Only ONE letter of the ALPHABET is accepted "
    puts "No other character is allowed "
    @letter = gets.chomp
    @letter = letter.downcase
end

# students.select{ |x| x[:name][0].downcase == letter.downcase}

@students
p @letter
end
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
if @user_response_final == "yes"
  selected = @students.map{|item| item.values}.flatten.select{ |chosen| chosen.to_s.chars.first.downcase == @letter.downcase }
p selected
#   # map{|item| item.values}.flatten.select do |name|
#   # if name.to_s.chars.first.downcase == @letter
#   # # if name.length < 12 && name != :november
#   # puts name
#   # end
# end
  index = 0
countStudent = selected.length
  puts "The students beginning with #{@letter} are:"
while countStudent > 0
  puts "#{selected[index]}"
  puts "#{selected[]}"
  countStudent = countStudent - 1
  index = index + 1
end

else
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
end

# students.each.with_index do |student, index|
#     puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
#   end
# #
# count_student = students.length
# index = 0
# while count_student > 0
#   newIndex = "#{index}".to_i
#   puts "#{index+1}. #{students[newIndex][:name]} (#{students[newIndex][:cohort]} cohort)"
#   count_student -= 1
#   index += 1
# end


def print_footer
 puts "Overall, we have #{@students.count} great students"
end

students = input_students
print_header
print_students_list
print_footer
