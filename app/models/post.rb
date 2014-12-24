class Post < ActiveRecord::Base
  validates :body, presence: true, length: { minimum: 10, maximum: 800}

  belongs_to :user
end
