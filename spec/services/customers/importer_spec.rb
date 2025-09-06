require 'rails_helper'


RSpec.describe Customers::Importer do
    let(:valid_lines) do
        <<~TXT
        {"user_id": 1, "name": "Test", "latitude": "19.0", "longitude": "72.0"}
        {"user_id": 2, "name": "Test2", "latitude": "20.0", "longitude": "73.0"}
        TXT
    end


    it 'parses JSON-lines file' do
        file = StringIO.new(valid_lines)
        importer = described_class.new(file)
        result = importer.call
        expect(result.size).to eq(2)
        expect(result.first[:user_id]).to eq(1)
        expect(result.first[:name]).to eq('Test')
    end


    it 'raises on invalid JSON' do
        file = StringIO.new("{bad json}\n")
        importer = described_class.new(file)
        expect { importer.call }.to raise_error(Customers::Importer::ParseError)
    end
end