FactoryBot.define do
  factory :track do
    name "Test Track"
    description "Track description..."
    course { create(:course) }
    order 1
  end
end
