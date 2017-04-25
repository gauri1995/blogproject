class Article < ApplicationRecord 
	belongs_to :user
	has_many :comments
	has_many :taggings
    has_many :tags, through: :taggings
	validates :title , presence: true, allow_blank: false
   validates :description , presence: true, allow_blank: false
   has_attached_file :photo, styles: { thumb: "180x180#",small: "300x300>", medium: "500x600>", large:"900x500>" }
   validates_attachment_presence :photo
   validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/jpg', 'image/png']
   
 def tag_list
  self.tags.collect do |tag|
    tag.name
  end.join(", ")
end
end
