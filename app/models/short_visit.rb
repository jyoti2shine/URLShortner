class ShortVisit < ApplicationRecord
  belongs_to :short_url
  validates_presence_of :visitor_ip
end