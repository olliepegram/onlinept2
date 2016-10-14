class Listing < ApplicationRecord
  validates :name, :description, :price, presence: true
  validates :price, numericality: {greater_than: 0}
  validates :image, attachment_presence: true

  belongs_to :user
  has_many :orders
  # delegate :first_name, to: :user, allow_nil: true, prefix: true
  # delegate :email, to: :user, allow_nil: true, prefix: true
  # delegate :avatar, to: :user, allow_nil: true, prefix: true

  has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
