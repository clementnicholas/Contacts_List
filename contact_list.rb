require_relative 'contact'
require_relative 'contact_database'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets
p ContactDatabase.read_list

  puts "Enter a command:"
  user_input = gets.chomp.downcase

  case user_input
  when 'new'
    puts "Enter a name:"
    input_name = gets.chomp
    puts "Enter an e-mail address:"
    input_email = gets.chomp
    new_contact = Contact.create(input_name, input_email)
  when 'list'
  when 'show'
  when 'find'
  when 'help'
    puts "Here is a list of available commands:
    new - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"
  else
  end


