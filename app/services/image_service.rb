class ImageService
  def create!(filename:, uri:)
    parsed_uri = ParsedUri.new(uri: uri)
    image = Image.new(content_type: parsed_uri.content_type, filename: filename)

    begin
      tempfile = write_to_temp_file(raw_data: parsed_uri.raw_data)
      image.attach_from_tempfile(tempfile: tempfile.path)
      image.save!
    ensure
      tempfile.unlink
    end

    image
  end



  def write_to_temp_file(raw_data:)
    file = Tempfile.new
    file.write raw_data
    file.close
    file
  end
end
