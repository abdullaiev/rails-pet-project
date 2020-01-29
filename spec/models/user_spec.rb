# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(3).is_at_most(25) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_presence_of(:full_name) }
  it { should validate_length_of(:full_name).is_at_most(100) }
  it { should have_many(:posts) }
  it { should have_many(:likes) }
  it { should have_many(:followers) }
  it { should have_many(:following) }
end
