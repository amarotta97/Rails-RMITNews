class Link < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :votes

  scope :hottest, -> { order(hot_score: :desc) }
  scope :newest, -> { order(created_at: :desc) }

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 10, maximum: 200 },
            format: { with: /\s[\w-]+\z/, message: "Must be at least 10 characters (including white spaces, new lines and tabs) "}
  validates :url,
            format: { with: %r{\Ahttps?://} },
            allow_blank: true

  def comment_count
    comments.length
  end
  
  def next
    Link.newest.limit(8).offset((@page - 1) * 8)
  end

  def set_page
    @page = params[:page] || 0
  end

  def upvotes
    votes.sum(:upvote)
  end

  def downvotes
    votes.sum(:downvote)
  end

  private

end
