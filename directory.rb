require "pry"

  @students = []
  @letter = ""
  @user_response = ""


def add_to_array(name, cohort)
  @students << {name: name, cohort: cohort, hobbies: :music, birthplace: :London, height: 1.90}
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
      if @students.empty?
      add_to_array(name, cohort)
      end 
    end
    file.close
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def print_menu
  puts "---------------------------"
  puts "What would you like to do?"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
  puts "---------------------------"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      puts "You chose option 1"
      input_students
    when "2"
      puts "You chose option 2"
      load_students
      show_students
    when "3"
      puts "You chose option 3"
      save_students
    when "4"
      puts "You chose option 4"
      load_students
    when "9"
      puts "You chose option 9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
  end

def interactive_menu
  loop do
  print_menu
  process(STDIN.gets.delete!("\n"))
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.delete!("\n")
  while !name.empty?
    puts "Now enter the cohort for the new student."
    puts "Which cohort is the new student?"
    cohort = STDIN.gets.delete!("\n")

    while (cohort.downcase.match(/(january|february|march|april|may|june|july|august|september|october|november|december)/)) == nil do
      puts "Your answer was #{cohort}"
      puts "Please try again"
      puts "------------------------"
      cohort = STDIN.gets.delete!("\n")
    end

    cohort = cohort.capitalize.to_sym
    cohort = :November if cohort.empty?


    add_to_array(name, cohort)
    puts "Now we have #{@students.count} #{student_singular(@students.count)}"
    puts "Please enter another student name" if @students.length != 0
    puts "To finish, please press return twice" if @students.length != 0
    name = STDIN.gets.delete!("\n")
  end

  puts "Do you want to see the students with a name that starts with a specific letter?"
  puts "Please respond Yes or No."
  @user_response = STDIN.gets.delete!("\n")

  while (@user_response.downcase.match(/^[yes|no]+$/)) == nil do
    puts "Your response was #{@user_response}"
    puts "Please answer Yes or No. No other resonse is accepted"
    puts @user_response.downcase.chomp =~ /yes\b|no/
    @user_response = STDIN.gets.delete!("\n")
  end

  return @students if @user_response.downcase == "no"
  puts "Which letter?" if @user_response.downcase == "yes"

  @letter = STDIN.gets.delete!("\n")

  while (@letter.length != 1 || @letter[/[a-z]|[A-Z]/] == nil) do
    puts "Only ONE letter of the ALPHABET is accepted "
    puts "No other character is allowed "
    @letter = STDIN.gets.chomp
    @letter = @letter.downcase
  end


print_students_list

end

def student_singular(count)
  if count == 1 then "student" else "students" end
end

def print_header
  puts "The students of Villains Academy" if @students.count > 0
  puts "--------------------------------"
end

def print_students_list
  if @user_response.downcase == "yes"
    selected = @students.select{|hash| hash[:name].chars.first.downcase == @letter.downcase}

    selected.each.with_index(1) do |item, index|
      puts "#{index}. #{item[:name]} (#{item[:cohort]} cohort)".center(50)
      puts "Born in: #{item[:birthplace]}. Hobbies: #{item[:hobbies]}. Height: #{item[:height]}".center(60)
    end


  else
    if !@students.empty?
    new_array = []
    @students.each{|hash| new_array << hash[:cohort]}
    month_array = new_array.uniq
    count = 0
    cohort_array = []
      while count < month_array.length do
        cohort_array << @students.select{|hash| hash[:cohort] == month_array[count]}
        count = count + 1
      end

      cohort_array.flatten!

      cohort_array.each.with_index(1) { |x, index|
        puts "#{index}. #{x[:name]} (#{x[:cohort]} cohort)".center(50)
        puts "Born in: #{x[:birthplace]}. Height: #{x[:height]}. Hobbies: #{x[:hobbies]}. ".center(60)
      }
    else
      return []
    end
  end
end

def print_footer
 puts "Overall, we have #{@students.count} great #{student_singular(@students.count)}." if @students.count > 0
 puts "You have entered no students" if @students.count == 0
end

try_load_students
interactive_menu
