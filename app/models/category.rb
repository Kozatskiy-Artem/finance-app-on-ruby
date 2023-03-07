class Category < ApplicationRecord
    has_many :operations, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true

    paginates_per 10
end
