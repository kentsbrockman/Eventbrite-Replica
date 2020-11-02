class User < ApplicationRecord
  #after_create :welcome_send

  #validates :first_name, presence: true
  #validates :last_name, presence: true
  #validates :description, presence: true


  #def welcome_send
    #UserMailer.welcome_email(self).deliver_now
  #end
end
