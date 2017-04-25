class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :comments
  has_attached_file :photo, styles: { small: "300x300>", thumb: "100x100>" , large: "1100x500"}
  validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/jpg', 'image/png']
end
