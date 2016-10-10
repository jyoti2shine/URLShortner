require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  it { should validate_presence_of(:original_url) }
  it { should belong_to(:user) }
  it { should have_one(:short_visit) }
end