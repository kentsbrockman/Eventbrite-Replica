class UserMailer < ApplicationMailer
  default from: 'kents@yopmail.com'

  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://kents.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def email_to_guest(user, event)
    @user = user 
    @admin = event.admin
    @event = event

    mail(to: @user.email, subject: 'Tu es inscrit(e) à l\'événement du jour !')
  end

  def email_to_admin(admin, user, event)
    @admin = admin 
    @user = user
    @event = event

    mail(to: @admin.email, subject: 'Une autre personne s\'est inscrite à ton événement !')
  end
  
end
