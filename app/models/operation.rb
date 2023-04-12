class Operation < ApplicationRecord
  belongs_to :category

  validates :amount, numericality: { greater_than: 0}
  validates :odate, presence: true
  validates :description, presence: true

  paginates_per 10

  def self.get_amounts_by_categories(start_date, end_date)
    categories_and_amount = Operation.joins(:category)
    .where("odate BETWEEN ? AND ?", start_date, end_date)
    .group('categories.name')
    .order('SUM(amount) DESC')
    .sum(:amount)
    return categories_and_amount
  end
end
