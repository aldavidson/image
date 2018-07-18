require 'rails_helper'

describe ImageController do
  let(:fixtures_dir) { Rails.root.join('spec', 'fixtures') }
  let(:image_to_upload) { File.join(fixtures_dir, 'triple-facepalm.jpg') }
  let(:image_b64) { File.read(File.join(fixtures_dir, 'triple-facepalm.b64')) }

  describe 'a POST request' do
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
            expect(response.code).to eq('201')
          end

          describe 'image_id' do
            let(:image_id) { JSON.parse(response.body)['image_id'] }
            it 'is a JSON-encoded field in the body' do
              expect(image_id).to_not be_nil
            end

            it 'is the ID of the last-uploaded image' do
              expect(image_id).to eq(Image.last.id)
            end
          end
        end
      end
    end
  end

  describe 'a GET request' do
    context 'with an ID' do
      let(:id) { nil }

      context 'that exists' do
        let(:image) do
          ImageService.new.create!(
            filename: 'triple-facepalm.jpg',
            uri: "data:image/jpg;base64,#{image_b64}"
          )
        end
        let(:image_url) {
          rails_blob_path(image.file, disposition: "inline")
        }
        context 'in a json request' do
          let(:format) { :json }

          describe 'the response' do
            let(:response) do
              get :show, params: {id: image.id}, format: format
            end

            it 'has status 200' do
              expect(response.code).to eq('200')
            end

            it 'is json' do
              expect(response.content_type).to eq('application/json')
            end

            it 'is the image as JSON' do
              expect(response.body).to eq(image.to_json)
            end
          end
        end

        context 'with the content type of the image' do
          let(:format) { :json }

          it 'redirects to the rails blob url' do

          end
        end
      end
    end
  end
end
