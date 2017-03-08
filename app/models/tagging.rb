class Tagging < ApplicationRecord
  belongs_to :instruction
  belongs_to :tag
end
