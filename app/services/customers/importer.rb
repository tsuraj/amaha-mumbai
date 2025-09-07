
require 'json'
require 'stringio'

module Customers
  class Importer
    class ParseError < StandardError; end

    def initialize(file)
      @file = file
    end

    # returns array of hashes with keys :user_id, :name, :latitude, :longitude
    def call
      result = []
      io = to_io(@file)

      # This is to ensure we start at beginning
      io.rewind if io.respond_to?(:rewind)

      io.each_line.with_index(1) do |line, ln|
        next if line.strip.empty?
        begin
          obj = JSON.parse(line)
          unless obj['user_id'] && obj['name'] && obj['latitude'] && obj['longitude']
            raise ParseError, "missing key in line #{ln}"
          end
          result << {
            user_id: obj['user_id'],
            name: obj['name'],
            latitude: obj['latitude'],
            longitude: obj['longitude']
          }
        rescue JSON::ParserError => e
          raise ParseError, "invalid JSON on line #{ln}: #{e.message}"
        end
      end

      result
    end

    private

    def to_io(obj)
      if defined?(ActionDispatch::Http::UploadedFile) && obj.is_a?(ActionDispatch::Http::UploadedFile)
        return obj.tempfile
      end

      # If it's already a File or Tempfile (implements each_line), just return it
      return obj if obj.respond_to?(:each_line)

      # If it responds to read (e.g., a Rack::Test::UploadedFile might behave differently),
      # wrap it in a StringIO to provide each_line.
      if obj.respond_to?(:read)
        return StringIO.new(obj.read)
      end

      # As a last resort, try to coerce to string
      StringIO.new(obj.to_s)
    end
  end
end
