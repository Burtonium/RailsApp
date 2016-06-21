class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  ## CONSTANTS ##
  CONTENT_LIMIT = 140
  
  ## VALIDATION ##
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: CONTENT_LIMIT }

end
