class Revenue < ApplicationRecord
  validates :date, :description, :revenue_type, :value,
            presence: { message: 'não pode ficar em branco' }

  def self.daily_revenue(query_date = Date.today)
    where(date: query_date)
  end
end