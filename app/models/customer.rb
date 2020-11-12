class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true  #全角カタカナのみ入力許可
  validates :first_name_kana, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :phonenumber, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  enum is_deleted: {
    有効: false,
    退会済み: true
  }
  #deletedがfalse(有効)の場合はログイン可能
  def active_for_authentication?
  super && (self.is_deleted == '有効' )
  end
end
