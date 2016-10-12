require 'rails_helper'

RSpec.describe ShortVisit, type: :model do
  it { should belong_to(:short_url) }
  it { should validate_presence_of(:visitor_ip) }
end