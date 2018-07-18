# Convenience wrapper around a parsed data: URI with base64-encoded content
class ParsedUri
  attr_accessor :content_type, :base64_data, :raw_data

  def initialize(args = {})
    from_uri(args[:uri]) if args[:uri].present?

    @content_type = args[:content_type]
    @base64_data  = args[:base64_data]
    @raw_data     = args[:raw_data]
  end

  def from_uri(uri)
    @content_type = uri.sub(/data:([^;]+);.*/, '\1')
    @base64_data = uri.sub(/data:[^,]*,(.*)/, '\1')
    @raw_data = Base64.decode64(@base64_data)
  end
end
