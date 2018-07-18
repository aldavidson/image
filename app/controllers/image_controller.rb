class ImageController < ApplicationController
  include ActionController::Live
  before_action :parse_request_json!, only: [:create]
  before_action :setup_response_headers, only: [:download]

  def create
    image = ImageService.new.create!(
      filename: @body_json['image']['filename'],
      uri: @body_json['image']['uri']
    )
    render json: {image_id: image.id}, status: :created
  end

  def show
    @image = Image.find(params[:id])

    if request.format.json?
      render json: @image
    elsif @image.file.content_type == request.format.to_s
      redirect_to url_for(@image.file)#, disposition: 'attachment')
    else
      render :no_content, status: :unacceptable
    end
  end

  def download
    @image = Image.find(params[:id])
    # redirect_to rails_blob_path(image.file, disposition: "attachment")
    storage_service.download(params[:id]) do |chunk|
      response.stream.write(chunk)
    end
  ensure
    response.stream.close
  end


  private

  def parse_request_json!
    if request.format.json?
      @body_json = JSON.parse(request.body.read)
    end
  end

  def setup_response_headers
    response.headers['Content-Type'] = params[:content_type] || DEFAULT_SEND_FILE_TYPE
    response.headers['Content-Disposition'] = params[:disposition] || DEFAULT_SEND_FILE_DISPOSITION
  end

  def storage_service
    ActiveStorage::Blob.service
  end
end
