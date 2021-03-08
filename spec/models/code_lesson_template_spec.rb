require 'rails_helper'

RSpec.describe CodeLessonTemplate, type: :model do
  it { should belong_to(:track_template) }

  it do
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_most(100)
  end

  it { should validate_presence_of(:instructions) }
  it { should validate_presence_of(:language_id) }
  it { should validate_presence_of(:order) }
  it { should validate_presence_of(:track_template) }
end
