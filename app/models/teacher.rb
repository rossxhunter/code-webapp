class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :teachers_classes
  has_many :organisation_classes, class_name: 'OrganisationClass', through: :teachers_classes
  has_many :assignments
  has_many :chat_messages, as: :messagable
  has_many :live_coding_sessions
  belongs_to :organisation

  validates :first_name,   presence: true
  validates :last_name,    presence: true
  validates :organisation, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def unresolved_live_coding_sessions
    live_coding_sessions.where(resolved: false)
  end
end
