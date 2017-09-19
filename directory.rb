require "csv"
require "pry"
  @students = []

  def print_menu
    puts "---------------------------"
    puts "What would you like to do?"
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list"
    puts "4. Load the list"
    puts "9. Exit"
    puts "---------------------------"
  end

  def interactive_menu
    loop do
    print_menu
    process(STDIN.gets.delete!("\n"))
    end
  end

def process(selection)
    ARGV.clear
    case selection
      when "1"
        puts "You chose option 1"
        input_students
      when "2"
        puts "You chose option 2."
        ask_filter
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


def add_to_array(name, cohort, hobby, birthplace, height)
  @students << {name: name, cohort: cohort, hobby: hobby, birthplace: birthplace, height: height}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.delete!("\n")
  while !name.empty? do
    puts "For which cohort?"
    cohort = gets.delete!("\n")
    while (cohort.downcase.match(/(january|february|march|april|may|june|july|august|september|october|november|december)/)) == nil
      #exiting loop if cohort is empty
      puts "The default cohort will be November" if cohort.empty?

      add_to_array(name, :november) if cohort.empty?
      puts "Your response was #{cohort}"
      puts "Please put the full month"
      puts "----------------------------------"
      puts "Please type the cohort again"
      cohort = gets.delete!("\n")
    end

    puts "What is #{name}'s main hobby?"
    hobby = gets.delete!("\n")

    puts "Please enter #{name}'s birthplace"
    birthplace = gets.delete!("\n")

    puts "Please enter #{name}'s height"
    height = gets.delete!("\n")

    puts "You entered #{name} for the #{cohort} cohort."
    puts "#{name}'s hobby: #{hobby}"
    puts "#{name}'s birthplace: #{birthplace}"
    puts "#{name}'s height: #{height}'"
    #add the student hash to the array
    add_to_array(name, cohort, hobby, birthplace, height)
    puts "Now we have #{@students.count} students"
    #get another name from the user
    name = STDIN.gets.delete!("\n")
  end
end

def ask_filter
  #Asking if user wants to filter the names by the first letter
  puts "Do you want to see the students with a name that starts with a specific letter?"
  puts "Please respond Yes or No."
  user_response = gets.delete!("\n")
  while(user_response.downcase.match(/(yes|no)/)) == nil do
    puts "Your response was #{user_response}"
    puts "Please answer Yes or No. No other response is accepted"
    user_response = gets.delete!("\n")
  end
  length_print_choice if user_response.downcase == "no"
  filter_letter_choice if user_response.downcase == "yes"
end

def filter_letter_choice
puts "Which letter?"
letter = gets.chomp
  while(letter.downcase.match(/^[a-z]|[A-Z]/)) == nil do
    puts "Your response was #{letter}"
    puts "Please enter a letter. No other character is allowed"
    letter = gets.delete!("\n")
  end
  new_array = @students.select{|x| x[:name][0].downcase == letter.downcase}
  filtered_list(letter, new_array)
end

def filtered_list(letter, new_array)
  puts "*********************************************************"
  puts "Here are the students starting with the letter #{letter}".center(50)
  puts "---------------------------------------------------------"
  new_array.each.with_index(1) do |student, index|
    puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
    puts "Born in: #{student[:birthplace]}. Hobbies: #{student[:hobby]}. Height: #{student[:height]}".center(50)
  end
  puts "In total, there are #{new_array.count} students starting with the letter #{letter}"
end

def show_students
  print_header
  print_student_list
end

def print_header
  puts "****************************************************"
  puts "The students of Villains Academy".center(50) if @students.count > 0
  puts "--------------------------------".center(50)
end

def length_print_choice
  puts "Do you want to filter out names more than 12 characters long?"
  puts "Please respond Yes or No."
  user_response = gets.delete!("\n")
  while(user_response.downcase.match(/^[yes|no]+$/)) == nil do
    puts "Your response was #{user_response}"
    puts "Please answer Yes or No. No other response is accepted"
    user_response = gets.delete!("\n")
  end
  show_students if user_response.downcase == "no"
   filter_length if user_response.downcase == "yes"
end

def filter_length
  new_arr = @students.reject{|x| x[:name].length > 12}
  print_filter_length(new_arr)
end

def print_filter_length(new_arr)
  puts "*******************************************************************"
  if new_arr == true
  puts "This is the list of students with names less than 12 characters long".center(50)
      new_arr.each.with_index(1) do |student, index|
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
        puts "Born in: #{student[:birthplace]}. Hobbies: #{student[:hobby]}. Height: #{student[:height]}".center(50)
      end
  else
    puts "We have #{new_arr.count} students with names less than 12 characters long".center(50)
  end
    puts "We have #{@students.count - new_arr.count} students with names more than 12 characters long".center(50)
    puts "------------------------------------------------------------------"
end

def print_student_list
  # @students.each.with_index(1) do |student, index|
  #   puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
  # end

  #######
  newArr = @students.group_by {|x| x[:cohort]}
  newArr.each do |cohort, arr|
    countStudent = arr.length
    index = 0
    puts "**********************************"
    puts "Here is the cohort for #{cohort.upcase}"
    puts "**********************************"

    while countStudent > 0
      newIndex = "#{index}".to_i
      puts "#{index + 1}. #{arr[newIndex][:name]}".center(50)
      puts "(#{arr[newIndex][:cohort]} cohort)".center(60)
      puts "Hobbies : #{arr[newIndex][:hobby]}, Height: #{arr[newIndex][:height]}, from #{arr[newIndex][:birthplace]}".center(50)
          countStudent = countStudent - 1
          index = index + 1
    end
  end
  print_footer
end

def student_singular(count)
  if count == 1 then "student" else "students" end
end

def translate(n)
    if 0 <= n && n <= 19
      %w(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)[n]
    elsif n % 10 == 0
      %w(zero ten twenty thirty forty fifty sixty seventy eighty ninety)[n/10]
    else
      "#{translate n/10*10}-#{translate n%10}".downcase
    end.capitalize
end

def print_footer
  puts "Overall, we have #{translate(@students.count)} great #{student_singular(@students.count)} ".center(50)
  puts "****************************************************".center(50)
end

def save_students
  file = ""
  puts "Please name the file you want to save otherwise we will use the default file"
  filename = gets.chomp
  if File.exists?(file)
    file = filename
  #open the file for writing
  else
    CSV.open("students.csv", "a+") do |csv|
    #iterate over the array of students
      @students.each do |student|
        csv << [student[:name], student[:cohort], student[:hobby], student[:birthplace], student[:height]]
      end
    end
  end
end

def load_students(filename = "students.csv")
  @students.clear

  file = ""
  puts "What filename to load? Please enter a current file otherwise we will load the default file name"
  filename = gets.chomp
  if File.exists?(filename)
    file = filename
  else
      CSV.foreach("students.csv") do |row|
        name, cohort, hobby, birthplace, height  = row[0], row[1], row[2], row[3], row[4]
        add_to_array(name, cohort, hobby, birthplace, height)
      end

  end
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded#{@students.count} from #{filename}"
  else
    puts "Sorry #{filename} does not exist"
    exit
  end
end

try_load_students
interactive_menu
