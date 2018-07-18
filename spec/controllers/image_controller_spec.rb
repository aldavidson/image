require 'rails_helper'

describe ImageController do
  let(:fixtures_dir) { Rails.root.join('spec', 'fixtures') }
  let(:image_to_upload) { File.join(fixtures_dir, 'triple-facepalm.jpg') }
  let(:image_md5) { '769407b5fa693f708b1ba2ec7cfc6407' }
  let(:image_b64) { File.read(File.join(fixtures_dir, 'triple-facepalm.b64')) }

  describe 'a POST request' do
    context 'with the file encoded as form-data' do

    end

    context 'with content_type JSON' do
      let(:format) { :json }

      context 'and the image Base64-encoded as a data: uri' do
        let(:body) {
          {
            'image': {
              'filename': 'triple-facepalm.jpg',
              'uri': "data:image/jpg;base64,#{image_b64}",
            }
          }.to_json
        }
        describe 'the response' do
          let(:response) do
            post :create, body: body, format: format
          end

          it 'has status 201 (created)' do
            expect(response.code).to eq(201)
          end

          describe 'image_id' do
            let(:image_id) { JSON.parse(response.body)['image_id'] }
            it 'is a JSON-encoded field in the body' do
              expect(image_id).to_not be_nil
            end

            it 'is the MD5 digest of the uploaded image' do
              expect(image_id).to eq(image_md5)
            end
          end
        end
      end
    end
  end
end
