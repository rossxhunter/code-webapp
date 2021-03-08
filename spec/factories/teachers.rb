FactoryBot.define do
  factory :teacher do
    email { Faker::Internet.email }
    password { 'password' }
    first_name { Faker::Name.name.split(' ')[0] }
    last_name { Faker::Name.name.split(' ')[1] }
    organisation { create(:organisation) }
  end
end
