class Meal < ApplicationRecord


  #include ActiveModel::Serialization
  #include ActiveModel::Serializers::JSON

  mount_uploader :image, FileUploader
  serialize :image, JSON # If you use SQLite, add this line.
  validates :content, {presence: true, length: {maximum: 5000}}
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :meal_type, {presence: true}
  validates_integrity_of :image

  belongs_to :user

  has_and_belongs_to_many :books
  has_many :comments, dependent: :destroy

  enum meal_type: { appetizer: 1, main_dish: 2, side_dish: 3, desert: 4 }

  #enum star: {  free: false,  pre: true }
  #validates :image, file_size: { less_than: 500.kilobytes }
  #validate :file_size
  #attr_accessor :title


  #validates_size_of :picture, maximum: 500.kilobytes, message: "should be less than 500KB"

  # FILE_VALIDATIONS = {
  # content_types: ["image/jpg", "image/jpeg", "image/png"],
  #max_size: 5.megabytes,
  # max_size: 600.kilobytes,
  # min_size: 1.kilobyte
  # }

  #belongs_to :users, :foreign_key => "user_id"


  def capitalized_title
    #return  self.title.capitalize
    return title.capitalize
  end



  def show_comments

    return comments
  end
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
