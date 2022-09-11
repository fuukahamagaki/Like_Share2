class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  #has_many :favorited_users, through: :favorites, source: :user
  has_many :post_comments, dependent: :destroy
  validates :title, presence:true, length:{in:2..20}
  validates :body, presence:true, length:{maximum:200}

  def favorited_by?(user)
   favorites.where(user_id: user.id).exists?
  end

end
