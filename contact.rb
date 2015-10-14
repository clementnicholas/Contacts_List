require 'pry'
require 'pg'

class Contact

  def self.connection
    puts 'Connecting to the database...'
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development'
        )
    conn
  end
 
  attr_accessor :first_name, :last_name, :email, :id

  def initialize(first_name, last_name, email)
    # TODO: assign local variables to instance variables
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = nil
  end

 
  def save

    if @id
      update_contact = "UPDATE contacts SET firstname='#{@first_name}', lastname='#{@last_name}', email='#{@email}'
      WHERE id='#{@id}'"
      Contact.connection.exec_params(update_contact)
    else  
      insert_contact = "INSERT INTO contacts (firstname, lastname, email) VALUES
      ('#{@first_name}', '#{@last_name}', '#{@email}')"
      Contact.connection.exec_params(insert_contact)

      id_hashes = Contact.connection.exec_params('SELECT id FROM contacts').map do |result|
        result
      end
      last_hash = id_hashes[-1]
      puts @id = last_hash['id']
    end
  end  

  def self.all
    contacts = []
    results = Contact.connection.exec_params('SELECT * FROM contacts')
    results.each do |result|
      contacts << result
    end
    contacts
  end

  def destroy
    Contact.connection.exec_params('DELETE * FROM contacts')
  end


  def self.find(id_number)
    results = Contact.connection.exec_params('SELECT * FROM contacts')
    contact_array = []
    results.each do |result|
      if result["id"] == id_number.to_s
        contact_array << result
      end
    end 
    contact_array
  end

  def self.find_all_by_lastname(name)
    results = Contact.connection.exec_params('SELECT * FROM contacts')
    contact_array = []
    results.each do |result|
      if result["lastname"] == name.to_s
        contact_array << result
      end
    end 
    contact_array
  end

  def self.find_all_by_firstname(name)
    results = Contact.connection.exec_params('SELECT * FROM contacts')
    contact_array = []
    results.each do |result|
      if result["firstname"] == name.to_s
        contact_array << result
      end
    end 
    contact_array
  end

  def self.find_by_email(email)
    results = Contact.connection.exec_params('SELECT * FROM contacts')
    contact_array = []
    results.each do |result|
      if result["email"] == email.to_s
        contact_array << result
      end
    end 
    contact_array
  end
 
  # puts self.all

  puts Contact.find(5)  
  puts Contact.find_all_by_lastname('woods')
  contact = Contact.new("Nick", "Jordan", "nickjordan")
  contact.save
  puts Contact.all
  contact.destroy
  puts Contact.all
end

