class Tag < ApplicationRecord
    # tr￥￥thro~中間テーブルとすることでアソシエーション
    has_many :books,through: :book_tag
    has_many:book_tag
    validates :name, uniqueness: true
end
