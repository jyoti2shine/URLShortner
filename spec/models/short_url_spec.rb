require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  it { should validate_presence_of(:original_url) }
end