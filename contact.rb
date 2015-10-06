class Contact
 
  attr_accessor :name, :email, :contact_array

  def initialize(name, email)
    # TODO: assign local variables to instance variables
    @name = name
    @email = email
    @contact_array = []
  end
 
  def to_s
    # 
  end
 


  ## Class Methods
  class << self

    @@id = 0

    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      @all_contacts = ContactDatabase.read_list
      @@id += @all_contacts.size + 1 
      @contact_array = []
      @contact_array << @@id
      @contact_array << name
      @contact_array << email
      ContactDatabase.write_to_list(@contact_array)
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      included = false
      output = ''
      ContactDatabase.read_list.each do |row|
        row.each do |str|
          if str.include?(term) 
            output << "ID: #{row[0]} \nNAME: #{row[1]} \nEMAIL: #{row[2]} \n"
            included = true
          end
        end
      end
      included == false ? contact_not_found : output
    end
 
    def all
      # TODO: Return the list of contacts, as is
      printed_contacts = ContactDatabase.read_list
      printed_contacts.each do |row|
        show_data(row)
      end
    end

    def show_data(obj)
      string = ''
      string << "#{obj[0]}: #{obj[1]} (#{obj[2]})"
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
      found = false
      output = ''
      contacts = ContactDatabase.read_list
      contact = contacts.find do |row| 
        if row[0] == id
          output << "ID: #{row[0]} \nNAME: #{row[1]} \nEMAIL: #{row[2]} \n"
          found = true
        end
      end
      found == false ? declare_invalid : output
    end
    
  end
 
end