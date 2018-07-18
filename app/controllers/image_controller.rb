class ImageController < ApplicationController
  before_action :parse_request_json!, only: [:create]

  def create
    image = ImageService.new.create!(
      filename: @body_json['image']['filename'],
      uri: @body_json['image']['uri']
    )
    render json: {image_id: image.id}, status: :created
  end

  def show
    image = Image.find(params[:id])
    redirect_to rails_blob_path(image.file, disposition: "attachment")

  end


  private

  def parse_request_json!
    if request.format.json?
      @body_json = JSON.parse(request.body.read)
    end
  end
end
