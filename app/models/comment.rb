class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :article

  attr_accessible :article_id, :body, :user_id

  validates :user_id, :presence => true
  validates :article_id, :presence => true
  validates :body, :presence => true, :length => { :maximum => 50000 } # spam protection

  default_scope :order => 'comments.created_at asc'
end
