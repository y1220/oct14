class Book < ApplicationRecord
    has_and_belongs_to_many :meals
end
