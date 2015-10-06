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
    end
 
    def all
      # TODO: Return the list of contacts, as is
      printed_contacts = ContactDatabase.read_list
      printed_contacts.each do |row|
        add_data(row)
      end
    end

    def add_data(obj)
      string = ''
      string << "#{obj[0]}: #{obj[1]} (#{obj[2]})"
      puts string
    end

    def show(id)
      # TODO: Show a contact, based on ID
    end
    
  end
 
end