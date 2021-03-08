require 'rails_helper'

RSpec.describe Organisation, type: :model do
  it { should have_many(:organisation_classes) }

  it { should validate_presence_of(:name) }
end
