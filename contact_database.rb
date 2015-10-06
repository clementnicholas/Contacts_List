## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase
  @@filename = 'contacts.csv'
  $filedata = []

  def intialize
    
  end

  def self.read_list
    CSV.read(@@filename)
  end

  def self.write_to_list(data)
    CSV.open(@@filename, 'a') do |file|
      file << data
      end
  end  

end