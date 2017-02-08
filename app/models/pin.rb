class Pin < ActiveRecord::Base
  acts_as_votable
  belongs_to :user

  has_attached_file :image, :styles => {  medium: "250x", thumb: "150x"  }, :default_url => "default.jpg",
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :title, :description, :image, presence: true
end
