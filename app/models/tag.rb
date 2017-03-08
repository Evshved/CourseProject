class Tag < ApplicationRecord
  has_many :taggings
  has_many :instructions, through: :taggings
  def self.counts
    self.select("name, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def camelize
    "#{self.name}.camelize"
  end
end
