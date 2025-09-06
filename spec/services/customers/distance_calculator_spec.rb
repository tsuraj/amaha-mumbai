require 'rails_helper'


RSpec.describe Customers::DistanceCalculator do
    describe '.deg2rad and .distance_km' do
        it 'calculates zero distance for same coords' do
            dist = Customers::DistanceCalculator.distance_km(19.0590317, 72.7553452)
            expect(dist).to be_within(0.0001).of(0.0)
        end


        it 'computes a known distance (approx) for a point ~100 km away' do
            dist = Customers::DistanceCalculator.distance_km(20.0, 72.7553452)
            expect(dist).to be_within(20).of(100) # allow tolerance
        end
    end
end