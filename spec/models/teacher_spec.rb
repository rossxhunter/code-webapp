require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:teacher) { create(:teacher) }

  it { should have_many(:organisation_classes).class_name('OrganisationClass').through(:teachers_classes) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:organisation) }

  it 'should return the correct full name' do
    expect(teacher.name).to eq("#{teacher.first_name} #{teacher.last_name}")
  end
end
