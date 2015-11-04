class CreateContacts < ActiveRecord::Migration
  def change
    drop_table :messages

    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.timestamps
    end

    create_table :numbers do |t|
      t.string :phone_type
      t.string :phone_number
      t.references :contact
      t.timestamps
    end
  end

end
