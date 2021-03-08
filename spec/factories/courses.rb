FactoryBot.define do
  factory :course do
    name "Test Course"
    teacher_id { create(:teacher).id }
    description "Test description..."
    organisation_id { create(:organisation).id }
  end
end
