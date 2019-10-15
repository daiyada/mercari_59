class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :card
  has_one :address
  accepts_nested_attributes_for :address
  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item"

  #STEP1,2入力項目validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  with_options presence: true do
    validates :nickname
    validates :email
    validates :password
    validates :name_family
    validates :name_first
    validates :name_family_kana
    validates :name_first_kana
    validates :cellphone_number
  end
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: {minimum: 7, maximum: 128}

  #STEP2入力項目validation
  validates :cellphone_number, uniqueness: true

end
