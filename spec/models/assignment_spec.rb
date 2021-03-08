require 'rails_helper'

RSpec.describe Assignment, type: :model do
  it { should belong_to(:teacher) }
  it { should belong_to(:student) }
  it { should belong_to(:code_lesson) }
end
