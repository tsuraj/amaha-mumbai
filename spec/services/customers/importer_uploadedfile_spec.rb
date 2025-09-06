require 'rails_helper'

RSpec.describe Customers::Importer, 'with ActionDispatch::Http::UploadedFile' do
  it 'parses an uploaded file' do
    sample = <<~TXT
    {"user_id": 1, "name": "Test", "latitude": "19.0", "longitude": "72.0"}
    {"user_id": 2, "name": "Test2", "latitude": "20.0", "longitude": "73.0"}
    TXT

    uploaded = Rack::Test::UploadedFile.new(StringIO.new(sample), 'text/plain', original_filename: 'customers.txt')
    importer = described_class.new(uploaded)
    result = importer.call

    expect(result.size).to eq(2)
    expect(result.first[:user_id]).to eq(1)
  end
end
