class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 80 }
  validates :teaser, presence: true, length: { maximum: 500 }
  validates :body, presence: true
  validates :version, length: { maximum: 120 }
  validates :changelog, length: { maximum: 2000 }
  validates :message, length: { maximum: 5000 }
  validates :state, presence: true, numericality: true, inclusion: { in: 0..4 }

  attr_accessible :accepted, :body, :changelog, :freezebody, :message, :state, :submitted, :teaser, :title, :user_id, :version, :created_at, :updated_at, :id

  # returns the number of ratings for that article
  def count_ratings
    self.ratings.all.count
  end

  # returns the average rating for that article
  def avg_rating
    @avg = self.ratings.average(:stars)     
    @avg ? @avg : 0
  end

  def self.search(search)
    if search
      where('title LIKE ? or teaser LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

end
