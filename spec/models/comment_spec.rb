# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should have_many(:reactions) }
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:post_id) }
  end
end
