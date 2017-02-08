class Order < ActiveRecord::Base
  belongs_to :pin
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  validates :address, :city, :state, :zip_code, presence: true
end
