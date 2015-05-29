class Relationlike < ActiveRecord::Base
	belongs_to :post, class_name: "Micropost"
	belongs_to :liker, class_name: "User"
	validates :post_id, presence: true
	validates :liker_id, presence: true
end
