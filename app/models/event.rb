class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :events_details
  has_many :attendees, through: :events_details

  scope :past, -> { where('date < ?', Date.today) }
  scope :now_and_future, -> { where('date >= ?', Date.today) }

end
