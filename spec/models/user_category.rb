RSpec.describe UserCategory, type: :model do
  it { is_expected.to belong_to(:users) }
  it { is_expected.to belong_to(:categories) }
end