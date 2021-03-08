require 'rails_helper'

RSpec.describe Submission, type: :model do
  it { should belong_to(:code_lesson) }

  it { should validate_presence_of(:code_lesson) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:student_id) }
end
