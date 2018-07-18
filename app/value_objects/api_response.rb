# convenient wrapper around data & errors, headers, etc
class ApiResponse
  attr_accessor :data, :errors, :headers

  def initialize(args = {})
    @data = args[:data]
    @errors = args[:errors]
    @headers = args[:headers]
  end

  def to_json(*args)
    {
      data: @data,
      errors: @errors
    }
  end
end
