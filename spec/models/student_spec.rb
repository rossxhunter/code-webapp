require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { create(:student) }

  it { should have_many(:organisation_classes).class_name('OrganisationClass').through(:students_classes) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:organisation) }

  it 'should return the correct full name' do
    expect(student.name).to eq("#{student.first_name} #{student.last_name}")
  end
end
