require 'rails_helper'

RSpec.describe OrganisationClass, type: :model do
  it { should belong_to(:organisation) }

  it { should have_many(:courses).class_name('Course').through(:classes_courses) }
  it { should have_many(:teachers).class_name('Teacher').through(:teachers_classes) }
  it { should have_many(:students).class_name('Student').through(:students_classes) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:organisation) }
end
