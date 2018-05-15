class User < ApplicationRecord
  has_many :links
  has_many :comments
  has_many :votes
  has_secure_password

  validates :username,
            presence: true,
            length: { minimum: 2, maximum: 15 },
            uniqueness: true,
            format: { with: /\A[\w-]+\z/, message: "must only contain letters, digits, dashes and underscores." }

  validates :password, 
            presence: true,
            length: { minimum: 10 }
            
            
  validate :check_password_format

  def check_password_format
   regexps = {" must contain at least one lowercase letter" => /[a-z]+/, 
              " must contain at least one uppercase letter" => /[A-Z]+/, 
               " must contain at least one digit" => /\d+/, 
               " must contain at least one special character" => /[^A-Za-z0-9]+/}
    regexps.each do |rule, reg|
      errors.add(:password, rule) unless password.match(reg)
    end
  end

  def owns_link?(link)
    self == link.user
  end

  def owns_comment?(comment)
    self == comment.user
  end

  def upvote(link)
    votes.create(upvote: 1, link: link)
  end

  def upvoted?(link)
    votes.exists?(upvote: 1, link: link)
  end

  def downvote(link)
    votes.create(downvote: 1, link: link)
  end

  def downvoted?(link)
    votes.exists?(downvote: 1, link: link)
  end

  def remove_vote(link)
    votes.find_by(link: link).destroy
  end
end
