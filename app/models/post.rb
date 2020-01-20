class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :comments

    def self.search(search)
        if search
          Post.where(['title LIKE ? OR text LIKE ?', "%#{search}%", "%#{search}%"])
        else
          Post.all
        end
    end
end
