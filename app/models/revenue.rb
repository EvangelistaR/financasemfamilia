class Revenue < ApplicationRecord
  validates :date, :description, :revenue_type, :value,
            presence: { message: 'não pode ficar em branco' }

  belongs_to :user

  def self.daily_revenue(query_date = Time.zone.today)
    where(date: query_date)
  end
end
