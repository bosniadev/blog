# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe 'Associations' do
    it { should belong_to(:comment) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    subject { FactoryBot.build(:reaction) }

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:comment_id) }
    it { should validate_presence_of(:kind) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:kind, :comment_id) }
  end

  it { should define_enum_for(:kind).with(%i[thumbsup like smile]) }
end
