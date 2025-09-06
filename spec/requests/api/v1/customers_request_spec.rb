require 'rails_helper'


RSpec.describe 'POST /api/v1/customers/upload', type: :request do
    let(:sample_data) do
        <<~TXT
        {"user_id": 1, "name": "Vivaan Sharma", "latitude": "19.060", "longitude": "72.755"}
        {"user_id": 2, "name": "Far Away", "latitude": "-68.850431", "longitude": "-35.814792"}
        TXT
    end


    it 'returns only nearby customers sorted by user_id' do
        file = Rack::Test::UploadedFile.new(StringIO.new(sample_data), 'text/plain', original_filename: 'customers.txt')
        post '/api/v1/customers/upload', params: { file: file }


        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to be_an(Array)
        expect(json.size).to eq(1)
        expect(json.first['user_id']).to eq(1)
        expect(json.first['name']).to eq('Vivaan Sharma')
    end
end