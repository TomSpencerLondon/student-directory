require "pry"

  @students = []
  @letter = ""
  @user_response = ""
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
    @students << {name: name, cohort: :november, hobbies: :music, birthplace: :London, height: 1.90}
    puts "Now we have #{@students.count} students"
    #get another name from the user
    name = gets.chomp
  end

  # Asking if they want to filter the names by the first letter
  puts "Do you want to see the students with a name that starts with a specific letter?"
  puts "Please respond Yes or No."
  @user_response = gets.chomp

  while (@user_response.downcase.match(/^[yes|no]+$/)) == nil do
    puts "Your response was #{user_response}"
    puts "Please answer Yes or No. No other resonse is accepted"
    puts @user_response.downcase.chomp =~ /yes\b|no/
    @user_response = gets.chomp
  end

  # return @students if @user_response.downcase == "no"
  return @students if @user_response.downcase == "no"
  puts "Which letter?" if @user_response.downcase == "yes"

  @letter = gets.chomp

  while (@letter.length != 1 || @letter[/[a-z]|[A-Z]/] == nil) do
    puts "Only ONE letter of the ALPHABET is accepted "
    puts "No other character is allowed "
    @letter = gets.chomp
    @letter = @letter.downcase
  end

# students.select{ |x| x[:name][0].downcase == letter.downcase}

p @letter
p @user_response_final = @user_response.downcase
#returns the students array

end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
if @user_response_final == "yes"
  # selected = @students.map{|item| item.values}.flatten.select{ |chosen| chosen.to_s.chars.first.downcase == @letter.downcase }

selected = @students.select{|hash| hash[:name].chars.first.downcase == @letter.downcase}

selected.each.with_index(1) do |item, index|
  puts "#{index}. #{item[:name]} (#{item[:cohort]} cohort)"
  puts "Born in: #{item[:birthplace]}. Hobbies: #{item[:hobbies]}. Height: #{item[:height]}"
end


#   # map{|item| item.values}.flatten.select do |name|
#   # if name.to_s.chars.first.downcase == @letter
#   # # if name.length < 12 && name != :november
#   # puts name
#   # end
# end
  #   index = 0
  # countStudent = selected.length
  #   puts "The students beginning with #{@letter} are:"
  # while countStudent > 0
  #   puts "#{selected[index]}"
  #   countStudent = countStudent - 1
  #   index = index + 1
  # end

else
  count_student = @students.length
  index = 0
  while count_student > 0
  newIndex = "#{index}".to_i
  puts "#{index+1}. #{@students[newIndex][:name]} (#{@students[newIndex][:cohort]} cohort)"
  puts "Born in: #{@students[newIndex][:birthplace]}. Height: #{@students[newIndex][:height]}. Hobbies: #{@students[newIndex][:hobbies]}"
  count_student = count_student - 1
  index = index + 1
  end

  # @students.each.with_index do |student, index|
  #   puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  # end

end

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
