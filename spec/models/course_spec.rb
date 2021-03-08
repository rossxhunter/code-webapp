require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many(:organisation_classes).class_name('OrganisationClass').through(:classes_courses) }
  it { should have_many(:tracks).dependent(:destroy) }

  it { should validate_presence_of(:name) }
end
