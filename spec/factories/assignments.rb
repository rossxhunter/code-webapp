FactoryBot.define do
  factory :assignment do
    student { create(:student) }
    teacher { create(:teacher) }
    code_lesson { create(:code_lesson) }
    date_due "2018-06-05 16:31:24"
  end
end
