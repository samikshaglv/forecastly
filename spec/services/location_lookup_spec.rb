require 'rails_helper'
require 'ostruct'
RSpec.describe LocationLookup do
  test_cases = [
    {
      address: "1600 Amphitheatre Parkway, Mountain View, CA",
      expected: {
        postal_code: '94043',
        city: 'Mountain View',
        state: 'California',
        country: 'United States',
        coordinates: ['37.4221', '-122.0841']
      }
    },
    {
      address: "MG Road, Bangalore, India",
      expected: {
        postal_code: '560001',
        city: 'Bengaluru',
        state: 'Karnataka',
        country: 'India',
        coordinates: ['12.9716', '77.5946']
      }
    }
  ]

  test_cases.each do |test_case|
    context "when given the address '#{test_case[:address]}'" do
      let(:address) { test_case[:address] }
      let(:expected) { test_case[:expected] }

      before do
        fake_location = OpenStruct.new(
          postal_code: expected[:postal_code],
          city: expected[:city],
          state: expected[:state],
          country: expected[:country],
          coordinates: expected[:coordinates]
        )

        allow(Geocoder).to receive(:search).with(address).and_return([fake_location])
      end

      subject(:lookup) { described_class.new(address) }

      it "returns the correct postal code" do
        expect(lookup.zip_code).to eq(expected[:postal_code])
      end

      it "returns the correct city" do
        expect(lookup.city).to eq(expected[:city])
      end

      it "returns the correct state" do
        expect(lookup.state).to eq(expected[:state])
      end

      it "returns the correct country" do
        expect(lookup.country).to eq(expected[:country])
      end

      it "returns the correct coordinates" do
        expect(lookup.coordinates).to eq(expected[:coordinates])
      end

      it "is valid" do
        expect(lookup.valid?).to be true
      end
    end
  end
end
