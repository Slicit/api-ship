require 'json'
require 'net/http'

RSpec.describe 'GET api/v1/shipments index' do
  # Finally, we will make our API more user friendly
  # by adding some sorting, filtering and pagination

  context 'show' do
    # Company YALMART has three shipments,
    # departing (in order of id) Jan 1, Jan 3, Jan 2

    context 'show first shipment' do
      it 'show first shipment by id' do
        response = http_get "#{BASE_URL}/api/v1/shipments/1"
        expect(response.code.to_i).to eq(HTTP_SUCCESS)
        json = JSON.parse(response.body)
        expect(json['id']).to eq(1)
      end
    end

    context 'show invalid shipment' do
      it 'show invalid shipment by id' do
        response = http_get "#{BASE_URL}/api/v1/shipments/42"
        expect(response.code.to_i).to eq(HTTP_NOT_FOUND)
        json = JSON.parse(response.body)
        expect(json['errors']).to eq(['shipment not found'])
      end
    end
  end

  context 'unavaible write operations due to readonly DB' do
    it 'create shipment failing' do
      response = http "POST", "#{BASE_URL}/api/v1/shipments", { shipment: { name: 'new shipment' } }
      expect(response.code.to_i).to eq(HTTP_METHOD_NOT_ALLOWED)
      json = JSON.parse(response.body)
      expect(json['errors']).to eq(['method not allowed'])
    end

    it 'update shipment failing' do
      response = http "PATCH", "#{BASE_URL}/api/v1/shipments/1", { shipment: { name: 'new name' } }
      expect(response.code.to_i).to eq(HTTP_METHOD_NOT_ALLOWED)
      json = JSON.parse(response.body)
      expect(json['errors']).to eq(['method not allowed'])
    end

    it 'delete shipment failing' do
      response = http "DELETE", "#{BASE_URL}/api/v1/shipments/1"
      expect(response.code.to_i).to eq(HTTP_METHOD_NOT_ALLOWED)
      json = JSON.parse(response.body)
      expect(json['errors']).to eq(['method not allowed'])
    end
  end

end
