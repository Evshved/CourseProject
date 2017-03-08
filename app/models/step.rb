class Step < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :instruction
end
