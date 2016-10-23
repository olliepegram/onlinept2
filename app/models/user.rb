class User < ApplicationRecord
  validates :first_name, :email, :password, presence: true

  #depends on the existence of the user. If user is deleted so will listing.
  has_many :listings, dependent: :destroy
  
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"


    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    devise :omniauthable, omniauth_providers: [:facebook]

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0, 20]
            user.first_name = auth.extra.raw_info.first_name   # assuming the user model has a name
            user.avatar = auth.info.image # assuming the user model has an image
        end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
