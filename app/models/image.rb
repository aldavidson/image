class Image < ActiveRecord::Base
  has_one_attached :file
end
