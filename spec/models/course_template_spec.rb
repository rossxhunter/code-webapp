require 'rails_helper'

RSpec.describe CourseTemplate, type: :model do
  it { should have_many(:track_templates).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
