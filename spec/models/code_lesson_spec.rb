require 'rails_helper'

RSpec.describe CodeLesson, type: :model do
  let(:code_lesson) { create(:code_lesson) }

  it { should belong_to(:track) }
  it { should have_many(:submissions).dependent(:destroy) }

  it do
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_most(100)
  end

  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:instructions).on(:update) }
  it { should validate_presence_of(:track).on(:update) }
  it { should validate_presence_of(:visible).on(:update) }

  context '#submissions_for' do
    it 'should get all submissions for the given student' do
      student = create(:student)

      submission1 = code_lesson.submissions.create(
        code: "puts 'test'",
        student_id: student.id,
        used_hint: false
      )

      submission2 = code_lesson.submissions.create(
        code: "puts 'test2'",
        student_id: student.id,
        used_hint: false
      )

      expect(code_lesson.submissions_for(student)).to eq([submission1, submission2])
    end
  end

  context '#submission_count_for' do
    it 'should give the correct count' do
      student = create(:student)

      submission1 = code_lesson.submissions.create(
        code: "puts 'test'",
        student_id: student.id,
        used_hint: false
      )

      submission2 = code_lesson.submissions.create(
        code: "puts 'test2'",
        student_id: student.id,
        used_hint: false
      )

      expect(code_lesson.submission_count_for(student)).to eq(2)
    end
  end

  context '#most_recent_submission_for' do
    it 'should give the most recent submission' do
      student = create(:student)

      submission1 = code_lesson.submissions.create(
        code: "puts 'test'",
        student_id: student.id,
        used_hint: false
      )

      submission2 = code_lesson.submissions.create(
        code: "puts 'test2'",
        student_id: student.id,
        used_hint: false
      )

      expect(code_lesson.most_recent_submission_for(student)).to eq(submission2)
    end
  end
end
