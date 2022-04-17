# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should have_many(:comments) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:user_id) }
  end

  describe '.filter_by_user_id' do
    let(:user_id) { create(:user).id }
    let(:post) { create(:post, user_id:) }

    context 'when post has a user_id' do
      let(:filter_user_id) { user_id }

      it 'returns post' do
        expect(Post.filter_by_user_id(filter_user_id)).to include(post)
      end
    end

    context 'when post does not have user_id' do
      let(:filter_user_id) { create(:user).id }

      it 'does not return the post' do
        expect(Post.filter_by_user_id(filter_user_id)).not_to include(post)
      end
    end
  end
end
