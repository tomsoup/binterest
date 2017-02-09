class Order < ActiveRecord::Base
  belongs_to :pin
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  attr_accessor :card_number, :card_cvc, :card_expires_month, :card_expires_year, :card_holder

  validates :address, :city, :state, :zip_code, presence: true
end
