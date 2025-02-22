class Mask < ApplicationRecord
    validates :skintype, presence: true
    has_one_attached :image
    before_validation :set_default_name, on: :create

    belongs_to :user

    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

  
    validates :profile, length: { maximum: 200 }

  private
  def set_default_name
     self.name ||= self.mask_name
  end
end
