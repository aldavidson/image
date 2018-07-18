# README

Sample image upload/retrieval microservice. Runs on Ruby 2.5.0, Rails 5.2

## Setup

Standard Rails app setup:

```ruby
# if you are using rbenv to manage Ruby versions:
rbenv local 2.5.0

# install gems:
gem install bundler
bundle install

# create DB & set it up
bundle exec rails db:create
bundle exec rails db:migrate

# run a server 
bundle exec rails s

# run the tests
bundle exec rspec
```


# Usage

There are 2 methods available, and a sample image in spec/fixtures. Uploading images via API is always fiddly, I went with the base64-encoded data: URI method as it translates most naturally to a JSON API.

### POST a new image:

First, read the sample data 
```ruby
irb> fixtures_dir = Rails.root.join('spec', 'fixtures'); image_b64 = File.read(File.join(fixtures_dir, 'triple-facepalm.b64'));nil
=> nil
irb> h = {'image': {'filename': 'triple-facepalm.jpg', 'uri': "data:image/jpg;base64,#{image_b64}"}}
```

Then, make the POST request:
```ruby
irb> r = RestClient::Request.new(method: :post, url: 'http://localhost:3000/images.json', payload:h.to_json, headers: { :accept => :json, content_type: :json })
=> <RestClient::Request @method="post", @url="http://localhost:3000/images.json">
irb> response = r.execute
=> <RestClient::Response 201 "{\"image_id\"...">
irb> response.body
=> "{\"image_id\":5}"
```

### GET an image

Available from /images/(id).
