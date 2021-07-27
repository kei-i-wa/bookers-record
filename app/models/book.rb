class Book < ApplicationRecord
  belongs_to:user

validates :title, presence: true
validates :body, presence: true,length:{maximum:200}
has_many :book_comments, dependent: :destroy
has_many :favorites, dependent: :destroy
has_many :favorited_users, through: :favorites, source: :user

 def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
 end
 scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
  scope :created_2days, -> { where(created_at: 2.days.ago.all_day) } 
  scope :created_3days, -> { where(created_at: 3.days.ago.all_day) } 
  scope :created_4days, -> { where(created_at: 4.days.ago.all_day) } 
  scope :created_5days, -> { where(created_at: 5.days.ago.all_day) } 
  scope :created_6days, -> { where(created_at: 6.days.ago.all_day) } 
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  
  # protected
  
  #  ransacker :favorites_count do
  #   query = '(SELECT COUNT(favorites.book_id) FROM favorites where favorites.book_id = books.id GROUP BY favorites.books_id)'
  #   Arel.sql(query)
  # end

end
