require "csv"
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


def add_to_array(name)
  @students << {name: name, cohort: :november}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    #add the student hash to the array
    add_to_array(name)
    puts "Now we have #{@students.count} students"
    #get another name from the user
    name = STDIN.gets.chomp
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "****************************************************"
  puts "The students of Villains Academy".center(50) if @students.count > 0
  puts "--------------------------------".center(50)
end

def print_student_list
  @students.each.with_index(1) do |student, index|
    puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
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
  file = File.open("students.csv", "w")
  #iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  file.close
end

def load_students(filename = "students.csv")
  file = ""
  puts "What filename to load? Please enter a current file otherwise we will load the default file name"
  filename = gets.chomp
  if File.exists?(filename)
    file = filename
  else
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
end
  file.close
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
