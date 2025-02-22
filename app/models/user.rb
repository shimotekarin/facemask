class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :image 

  has_many :masks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :mask

  def already_liked?(mask)
    self.likes.exists?(mask_id: mask.id)
  end

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  
end