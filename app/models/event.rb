class Event < ApplicationRecord

  validates :start_date,
    presence: true,
    date: { after: Proc.new { Date.today }, message: 'must be after today' },
    on: :create
  validates :duration, presence: true, numericality: { greater_than: 0 }, if: (:duration % 5).zero?
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000 }
  validates :location, presence: true
  
  has_many :attendances
  has_many :users, through: :attendances

  belongs_to :user, class_name: "Admin"

  

end
