class Genre < ApplicationRecord
  has_many :items

  enum is_status: {
    有効: true,
    無効: false
  }

  validates :name, presence: true, uniqueness: true

end
