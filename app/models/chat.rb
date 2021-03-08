class Chat < ApplicationRecord
  belongs_to :code_lesson
  belongs_to :student
  has_many :chat_messages

  def self.find_all_for_teacher(teacher)
    chats = []

    teacher.organisation_classes.each do |org_class|
      org_class.courses.each do |course|
        course.tracks.each do |track|
          track.code_lessons.each do |code_lesson|
            chat = Chat.where(code_lesson_id: code_lesson.id).to_a
            chats = [chats, chat].flatten
          end
        end
      end
    end

    chats
  end
end
