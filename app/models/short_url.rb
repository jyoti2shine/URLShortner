class ShortUrl < ApplicationRecord
  belongs_to :user
  has_one :short_visit

  validates_presence_of :original_url,:user_id

  after_create do |shorturl|
    shorturl.shorty = shorturl.generate_shorty
    shorturl.save
  end

  def generate_shorty
    self.id.to_s(36)
  end

  def display_shorty
    Rails.configuration.base_url + self.shorty
  end

  def increment_counter
    self.update_attribute("visits",self.visits+1)
  end
end