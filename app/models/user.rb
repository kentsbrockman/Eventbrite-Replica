class User < ApplicationRecord
  after_create :welcome_send

  validates :name, presence: true
  validates :email, presence: true

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
