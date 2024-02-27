class User < ApplicationRecord
  authenticates_with_sorcery!
  before_create :set_user_id

  has_many :spots, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_spots, through: :likes, source: :spot
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  
  validates :password, length: { minimum: 7 }, if: -> { new_record? || changes[:crypted_password]}
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] },unless: :guest
  validates :last_name, length: { maximum: 255 }
  validates :first_name,  length: { maximum: 255 }
  validates :email, presence: true
  # self.guest_loginメソッドの場合はユニーク制約を無視する
  validates :email, uniqueness: true ,unless: :guest

  enum gender: { other: 0, male: 1, female: 2 }

  mount_uploader :avater, AvaterUploader

  def own?(object)
    id == object.user_id
  end

  private

    # ランダムなユーザーIDを生成
    def set_user_id
      while self.id.blank? || User.find_by(id: self.id).present? do
        self.id = SecureRandom.base58
      end
    end

    # ゲストユーザーを作成する
    def self.guest_login
      random_pass = SecureRandom.base36
      unique_email = "guest_#{Time.current.to_i}_#{SecureRandom.hex(4)}@example.com"
      create!(
        first_name: "ゲスト",
        last_name: "ユーザー",
        email: unique_email,
        password: random_pass,
        guest: true
      )
    end
end
