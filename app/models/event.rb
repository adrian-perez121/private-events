class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :events_details
  has_many :attendees, through: :events_details

  def self.past
    self.where('date < ?', Date.today)
  end

  def self.now_and_future
    self.where('date >= ?', Date.today)
  end
end
