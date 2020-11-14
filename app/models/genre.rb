class Genre < ApplicationRecord
  has_many :items

  enum is_status: {
    有効: true,
    無効: false
  }

  # バリデーション すでに存在しているジャンルと同じジャンル名であれば保存されない
  validates :name, uniqueness: true, presence: true
end
