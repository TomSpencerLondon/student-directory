require "pry"
require "csv"
  @students = []

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

  def interactive_menu
    loop do
    print_menu
    process(STDIN.gets.delete!("\n"))
    end
  end

def process(selection)
    case selection
      when "1"
        puts "You chose option 1"
        input_students
      when "2"
        puts "You chose option 2."
        show_students
      when "3"
        puts "You chose option 3"
        puts "Please name the file you want to save otherwise we will use the default file"
        file = gets.chomp
        save_students(file)
      when "4"
        puts "You chose option 4"
        puts "What filename to load? Please enter a current file otherwise we will load the default file name"
        filename = gets.chomp
        load_students(filename)
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

def save_students(file)
  if File.exists?(file)
      CSV.open(file, "w") do |file|
    #iterate over the array of students
      @students.each do |student|
        student_data = [student[:name], student[:cohort]]
        CSV.foreach(file) do |row|
        csv_line = student_data.join(",")
        file.puts csv_line
      end
      end
    end
    #open the file for writing
    else
    CSV.open("students.csv", "w") do |file|
    #iterate over the array of students
      @students.each do |student|
        student_data = [student[:name], student[:cohort]]
        CSV.foreach("students.csv") do |row|
        csv_line = student_data.join(",")
        file.puts csv_line
        end
      end
    end
  end
end

def load_students(filename)
  if File.exists?(filename)
    CSV.open(filename, "r") do |file|
        CSV.foreach(filename) do |row|
          name, cohort = row
          add_to_array(name)
        end
    end
  else
    CSV.open("students.csv", "r") do |file|
      CSV.foreach("students.csv") do |row|
        name, cohort = row
        add_to_array(name)
      end
    end
  end
end

def try_load_students
  filename = "students.csv" #first argument from the command line
  load_students(filename) if filename.nil? #get out of the method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded#{@students.count} from #{filename}"
  else #if it doesn't exist
    load_students
  end
end

try_load_students
interactive_menu
