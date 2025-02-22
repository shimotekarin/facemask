class Like < ApplicationRecord
  belongs_to :mask
  belongs_to :user

  validates_uniqueness_of :mask_id, scope: :user_id
end
