class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, length: { minimum: 7 }, if: -> { new_record? || changes[:crypted_password]}
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true
  validates :email, uniqueness: true

  enum gender: { other: 0, male: 1, female: 2 }
end