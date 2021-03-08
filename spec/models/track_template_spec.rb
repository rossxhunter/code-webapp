require 'rails_helper'

RSpec.describe TrackTemplate, type: :model do
  it { should belong_to(:course_template) }
  it { should have_many(:code_lesson_templates).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:order) }
  it { should validate_presence_of(:course_template) }
end
