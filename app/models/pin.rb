class Pin < ActiveRecord::Base
  acts_as_votable
  has_many :orders
  belongs_to :user

  if Rails.env.development?
    has_attached_file :image, styles: { medium: '250x', thumb: '150x' }, default_url: 'default.jpg'
  else
    has_attached_file :image, styles: { medium: '250x', thumb: '150x' }, default_url: 'default.jpg',
                              storage: :dropbox,
                              dropbox_credentials: Rails.root.join('config/dropbox.yml'),
                              :path => ":style/:id_:filename"
  end

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :title, :description, :image, presence: true
  # validates :price, numericality: { greater_than: 0 }
end
