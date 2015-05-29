class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  has_many :active_relationlikes,  class_name: "Relationlike",
                                    foreign_key: "post_id",
                                    dependent: :destroy  
  has_many :likings, through: :active_relationlikes, source: :liker

  def like(user)
    active_relationlikes.create(liker_id: user.id)
  end
  def unlike(user)
    active_relationlikes.find_by(liker_id: user.id).destroy
  end
  def likings?(user)
    likings.include?(user)
  end

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "La imagen debe de pesar menos de 5 Mb")
      end
    end
end

