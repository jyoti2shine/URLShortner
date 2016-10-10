require 'rails_helper'

RSpec.describe ShortVisit, type: :model do
  it { should belong_to(:short_url) }
end