class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :addresses, dependent: :destroy

  enum is_deleted: {
    有効: false,
    退会済み: true
  }
  #修正箇所ーーーーーdeletedがfalseの場合はログイン可能
  def active_for_authentication?
  super && (self.is_deleted == '有効')
  end
  #ココまでーーーーー
end
