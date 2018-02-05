class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,
         :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :questions
  has_many :answers
  has_many :authorizations
  has_many :subscriptions

  def subscribe_question(question)
    self.subscriptions.create(question: question)
  end

  def unsubscribe_question(question)
    subscription = self.subscriptions.where(question: question)
    Subscription.delete(subscription)
  end

  def author_of?(answer)
    return false if answer.blank?
    id == answer.user_id
  end

  def self.register_for_oauth(email, provider, uid)
    password = Devise.friendly_token[0, 20]
    user = User.create!(email: email, password: password, password_confirmation: password)
    user.authorizations.create(provider: provider, uid: uid)
  end

  def self.all_except(user)
    where.not(id: user)
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization
    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    elsif email
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.create_authorization(auth)
    else
      user = User.new
    end
    user
  end

  def self.send_daily_digest
    # load by 1000 objects
    find_each.each do |user|
      DailyMailer.digest(user).deliver_later
    end
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
