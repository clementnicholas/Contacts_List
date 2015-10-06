class Contact
 
  attr_accessor :name, :email, :contact_array

  def initialize(name, email)
    # TODO: assign local variables to instance variables
    @name = name
    @email = email
    @contact_array = []
  end
 
  def to_s

  end
 
  ## Class Methods
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      @contact_array = []
      @contact_array << name
      @contact_array << email
      # p @contact_array.inspect
      ContactDatabase.write_to_list(@contact_array)
      @all_contacts = ContactDatabase.read_list
      @all_contacts.each do |contact|
        puts $. if contact[0] == name 
      end
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
    end
 
    def all
      # TODO: Return the list of contacts, as is
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
    end
    
  end
 
end