## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

require 'bcrypt'
class User < ApplicationRecord
  has_secure_password
  before_save :before_save_checks
  #:create and :partialsave are context driven validation checks, they are only triggered when a matching context is given to this model
  validates :fname, length: { minimum: 2 , maximum:100}, presence: true, on: [:create, :partialsave]
  validates :lname, length: { minimum: 2 , maximum:100}, presence: true, on: [:create, :partialsave]
  #regex to match strings of the form email@smth.smth
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } , on: [:create, :partialsave]
  validates :password, presence: true, length: { minimum: 6 , maximum:50}, on: [:create, :pwchange]
  validates :username, presence: true, length: { minimum: 3 , maximum:30}, uniqueness: {case_sensitive: false}, on: [:create, :partialsave]

  private
  def before_save_checks()
    self.email = email.downcase
    self.username = username.downcase
    #if admin is not set to be true, default value is false
    self.admin  ||= false
  end
end
