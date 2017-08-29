require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'
require_relative './exercise_6'

puts "Exercise 7"
puts "----------"

# Your code goes here ...

#Add validations to two models to enforce the following business rules:

class Store < ActiveRecord::Base
  validates :name, length: { minimum: 3 } #Stores must always have a name that is a minimum of 3 characters
  validates_numericality_of :annual_revenue, presence: true, :only_integer => true, :greater_than_or_equal_to => 0 #Stores have an annual_revenue that is a number (integer) that must be 0 or more
  validate  :must_carry_mens_or_womens_apparel #BONUS: Stores must carry at least one of the men's or women's apparel (hint: use a custom validation method - don't use a Validator class)

  def must_carry_mens_or_womens_apparel
    errors.add(:base, "Store must carry either women's or men's apparel.") if (!mens_apparel && !womens_apparel)
  end
end

class Employee < ActiveRecord::Base
  validates :first_name, presence: true #Employees must always have a first name present
  validates :last_name, presence: true #Employees must always have a last name present
  validates :hourly_rate, presence: true #Employees have a hourly_rate that is a number (integer) between 40 and 200
  validates   :store_id,   presence: true #Employees must always have a store that they belong to (can't have an employee that is not assigned a store)
end

#Ask the user for a store name (store it in a variable)

puts "Please input a store name"
store_name = gets.chomp

#Attempt to create a store with the inputted name but leave out the other fields
#(annual_revenue, mens_apparel, and womens_apparel)

 @new_store = Store.create(name: store_name)

#Display the error messages provided back from ActiveRecord to the user (one on each line) after you attempt to save/create the record

if @new_store.errors.any?
  @new_store.errors.each do |attribute, message|
    puts "Error for #{attribute}: #{message}"
  end
end
