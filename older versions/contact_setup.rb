require 'pry' # in case you want to use binding.pry
require 'active_record'
require_relative 'contact'

# Output messages from Active Record to standard out
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contacts',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  encoding: 'unicode',
  pool: 5,
  min_messages: 'error'
)

puts 'CONNECTED'

puts 'Setting up Database (creating tables) ...'

ActiveRecord::Schema.define do
  # drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
  # drop_table :phones if ActiveRecord::Base.connection.table_exists?(:phones)
  unless ActiveRecord::Base.connection.table_exists?(:contacts)
    create_table :contacts do |contact|
      contact.column :first_name, :string
      contact.column :last_name, :string
      contact.column :email, :string
      contact.timestamps null: false
    end
  end

  unless ActiveRecord::Base.connection.table_exists?(:phones)
    create_table :phones do |table|
      table.references :contact
      table.column :kind, :string
      table.column :number, :string
      table.timestamps null: false
    end
  end
end


puts 'Setup DONE'
