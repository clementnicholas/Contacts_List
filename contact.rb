require 'pry'

class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    # TODO: assign local variables to instance variables
    @name = name
    @email = email
  end
 
  def to_s
    # 
  end


 


  ## Class Methods
  class << self



    @@id = 0
    @@found = false
    @@output = []

    def add_to_output(obj)
      if eval(obj[3]).empty?
        string_to_add = "ID: #{obj[0]} \nNAME: #{obj[1]} \nEMAIL: #{obj[2]}"
      else  
        string_to_add = "ID: #{obj[0]} \nNAME: #{obj[1]} \nEMAIL: #{obj[2]} \n#{print_numbers(obj[3])}"
      end
      @@output << string_to_add if @@output.include?(string_to_add) == false
      @@found = true
    end

    def create(name, email, phone_numbers)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      @all_contacts = ContactDatabase.read_list
      @@id += @all_contacts.size + 1 
      @contact_array = []
      @contact_array << @@id
      @contact_array << name
      @contact_array << email
      @contact_array << phone_numbers
      ContactDatabase.write_to_list(@contact_array)
      "Contact with ID: #{@@id} created."
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      ContactDatabase.read_list.each do |row|
        row.each do |str|
          if str.include?(term) 
            add_to_output(row)
          end
        end
      end
      @@found == false ? contact_not_found : @@output
    end
 
    def all
      # TODO: Return the list of contacts, as is
      printed_contacts = ContactDatabase.read_list
      printed_contacts.each do |row|
        show_data(row)
      end
    end

    def print_numbers(obj)
      @numbers_list = []
      eval(obj).each do |key, value|
        @numbers_list << "#{key.to_s.upcase}: #{value}"
      end
      @numbers_list.join(' ')
    end

    def show_data(obj)
      string = ''
      string << "#{obj[0]}: #{obj[1]} (#{obj[2]}) #{print_numbers(obj[3])}" 
      puts string
    end

    def contact_not_found
      "Contact not found. Please try another search."
    end

    def declare_invalid
      "Contact not found. Please enter a valid ID."
    end

    def show(id)
      # TODO: Show a contact, based on ID
      contacts = ContactDatabase.read_list
      contact = contacts.find do |row| 
        if row[0] == id
          add_to_output(row)
        end
      end
      @@found == false ? declare_invalid : @@output
    end
    
  end
 
end