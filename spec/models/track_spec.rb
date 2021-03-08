require 'rails_helper'

RSpec.describe Track, type: :model do
  it { should belong_to(:course) }
  it { should have_many(:code_lessons).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:order) }
  it { should validate_presence_of(:course) }
end
