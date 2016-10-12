class ShortUrl < ApplicationRecord
  belongs_to :user
  has_many :short_visits

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

  def create_short_visit(ip=nil)
    self.short_visits.find_or_create_by(visitor_ip: ip)
  end
end