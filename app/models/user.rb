class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :not_invited_to_event, ->(event_id) {
    where.not(id: Invite.select(:invited_id).where(event_id: event_id))
  }

  has_many :created_events, -> { order(date: :desc) }, foreign_key: :creator_id, class_name: "Event"
  has_many :events_details, foreign_key: :attendee_id
  has_many :attended_events, -> { order(date: :desc) }, through: :events_details, source: :event

  has_many :invites, foreign_key: :invited_id
  has_many :invited_events, through: :invites, source: :event
end
