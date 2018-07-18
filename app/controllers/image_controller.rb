class ImageController < ApplicationController
  def create
    byebug
    image_id = ImageService.new.create!(@image)
    respond_with ApiResponse.new(body: {image_id: @image_id})
  end

  private

  def extract_image_from_request
    
  end
end
