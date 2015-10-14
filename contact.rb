class Contact < ActiveRecord::Base 

  has_many:phones

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def print
    puts "ID: #{id}, NAME: #{first_name} #{last_name}, EMAIL: #{email}"
    phones.each do |phone|
      puts "PHONE TYPE: #{phone.kind}, NUMBER: #{phone.number}"
    end
  end

end

class Phone < ActiveRecord::Base

  belongs_to:contact

  validates :kind, :number, presence: true

end