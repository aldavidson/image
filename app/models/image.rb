class Image < ActiveRecord::Base
  has_one_attached :file

  def attach_from_tempfile(tempfile:, filename: self.filename)
    self.file.attach(io: File.open(tempfile), filename: filename)
  end
end
