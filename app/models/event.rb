class Event < ApplicationRecord

  validates :start_date,
    presence: true
    #start_date > Time.now
  validates :duration,
    presence: true
    #value > 0
    #value%5 = 0
  validates :title,
    presence: true,
    length: { in: 5..140 }
  validates :description,
    presence: true,
    length: { in: 20..1000 }
  validates :price,
    presence: true,
    #value: { in: 1..1000 }
  validates :location, presence: true

  has_many :attendances
  has_many :users, through: :attendances

  belongs_to :user, class_name: "Admin"

end
