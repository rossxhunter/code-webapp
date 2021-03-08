FactoryBot.define do
  factory :code_lesson do
    name "Ruby Code Lesson"
    instructions "Test instructions..."
    hint "Test hint..."
    starting_code { "def test(a); puts a; end" }
    language { create(:language) }
    order 1
    track { create(:track) }
    visible true
  end
end
