class Meal < ApplicationRecord

  mount_uploader :image, FileUploader

  validates :content, {presence: true, length: {maximum: 100}}
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :meal_type, {presence: true}
  validates :image, file_size: { less_than: 500.kilobytes }
  #validate :file_size


  #validates_size_of :picture, maximum: 500.kilobytes, message: "should be less than 500KB"

  # FILE_VALIDATIONS = {
  # content_types: ["image/jpg", "image/jpeg", "image/png"],
  #max_size: 5.megabytes,
  # max_size: 600.kilobytes,
  # min_size: 1.kilobyte
  # }

  #belongs_to :users, :foreign_key => "user_id"
  belongs_to :user


  has_many :comments, dependent: :destroy
  #def user
  #return User.find_by(id: self.user_id)
  #end
  #def size_range
  #   1.byte..500.kilobytes
  #  end

  #def file_size
  # if file.file.size.to_f/(1000*1000) > user.product_upload_limit.to_f
  #    errors.add(:file, "You cannot upload a file greater than #{upload_limit.to_f}MB")
  #   end
  #  end

  #def content_type_whitelist
  #  [/(text|application)\/json/]
  # end


end
