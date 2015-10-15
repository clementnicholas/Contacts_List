require_relative 'contact_setup'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets

def prompt_for_first_name
  puts "Enter a first name:"
  @firstname = gets.chomp
end

def prompt_for_last_name
  puts "Enter a last name:"
  @lastname = gets.chomp
end

def prompt_for_email
  puts "Enter an e-mail address:"
  @email = gets.chomp
end

def get_phone_number_and_type
  puts "Enter a type of phone_number:"
  @type_of_number = gets.chomp
  puts "Enter phone_number:"
  @phone_number = gets.chomp
end

def prompt_for_phone
  @response == 'YES'
  until @response == 'NO' do
  puts "Would you like to enter a phone_number? (YES or NO)"
  @response = gets.chomp.upcase
    if @response == 'YES'
      get_phone_number_and_type
      @new_contact.phones.create(kind: @type_of_number, number: @phone_number)
    end
  end
end

puts "Welcome to your contact list. What would you like to do:
>>> new -- Add a new contact
>>> update -- Update an existing contact
>>> all -- List all contacts
>>> delete -- Delete a contact
>>> find -- Find a contact by id_input

Please Enter a choice: "
user_input = gets.chomp

  case user_input
  when 'new'
    prompt_for_first_name
    prompt_for_last_name
    loop do
      prompt_for_email
      if Contact.exists?(email: @email)
        puts "A contact with that email already exists. Please enter another."
      else
        break loop
      end
    end
    @new_contact = Contact.create(first_name: @firstname, last_name: @lastname, email: @email)

    prompt_for_phone
    puts "New contact created with ID: #{@new_contact.id}."

  when 'all'
    Contact.all.each do |contact|
      contact.print
    end

  when 'update'
    puts "Enter a contact id:"
    contact_id = gets.chomp
    contact = Contact.find(contact_id)
    puts "Enter a new first name:"
    firstname = gets.chomp
    contact.update(first_name: firstname)

  when 'delete'
    puts "Enter a contact id:"
    Contact.delete(gets.chomp) 

  when 'find'
    puts "Find by ID: "
    id = gets.chomp.to_i
    if Contact.exists?(id: id) 
      Contact.find(id).print
    else
      puts "No Contact with ID# #{id}."
    end
  end


