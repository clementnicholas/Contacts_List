require_relative 'contact'
require_relative 'contact_database'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets

def prompt_for_name
  puts "Enter a name:"
  @input_name = $stdin.gets.chomp
end

def prompt_for_email
  puts "Enter an e-mail address:"
  @input_email = $stdin.gets.chomp
end

def get_phone_number
  puts "Enter a type of phone_number:"
  @type_of_number = $stdin.gets.chomp
  puts "Enter phone_number:"
  @phone_number = $stdin.gets.chomp
end

def prompt_for_phone
  @numbers = {}
  @response == 'YES'
  until @response == 'NO' do
  puts "Would you like to enter a phone_number? (YES or NO)"
  @response = $stdin.gets.chomp.upcase
    if @response == 'YES'
      get_phone_number
      @numbers[@type_of_number.to_sym] = @phone_number
    end
  end
end

def check_for_duplicate_email
  ContactDatabase.read_list.each do |row|
    if row[2] == @input_email
      return true
    end
  end  
end


  command = ARGV
  case command[0]
  when 'new'
    prompt_for_email
    if check_for_duplicate_email == true 
      puts "I'm sorry, a contact with that email already exists."
    else
      prompt_for_name
      prompt_for_phone
      puts Contact.create(@input_name, @input_email, @numbers)
    end

  when 'list'
    Contact.all
    puts "----------"
    puts "#{ContactDatabase.read_list.size} TOTAL CONTACTS"
  when 'show'
    id_input = command[1]
    puts Contact.show(id_input)
  when 'find'
    search_term = command[1]
    puts Contact.find(search_term)
  when 'help'
    puts "Here is a list of available commands:
    new - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"
  else
  end


