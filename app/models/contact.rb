class Contact < ActiveRecord::Base

  has_many :numbers

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true

end