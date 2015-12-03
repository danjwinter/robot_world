require 'sequel'
require 'sqlite3'

environments = ["test", "development"]

environments.each do |env|
  Sequel.sqlite("db/robot_world_#{env}.sqlite3").create_table(:robots) do
    primary_key :serial_number
    String :name
    String :city
    String :state
    String :avatar
    String :birthdate
    String :date_hired
    String :department
  end
end