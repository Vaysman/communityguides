class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :article

  attr_accessible :article_id, :stars, :user_id

  validates :user_id, :presence => true
  validates :article_id, :presence => true
  validates :stars, :presence => true, :numericality => true, :inclusion => { :in => 0..5 }
end
