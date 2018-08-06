# frozen_string_literal: true

require_relative '../spec_helper.rb'
require './app/models/user'
require './app/models/user_category'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:categories) }
  it { is_expected.to validate_presence_of :username }

  it { should validate_presence_of :password }
  it { should have_secure_password }
  it { should validate_confirmation_of :password }
  it { should validate_length_of(:password).is_at_least(8) }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  it { should have_db_column :password_digest }
  it { should have_db_column :email }
end
