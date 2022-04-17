# frozen_string_literal: true

require 'rails_helper'

describe Posts::CommentsHelper do
  describe '#can_react?' do
    let(:user) { create(:user) }
    let(:comment) { create(:comment) }

    before { allow(helper).to receive_message_chain(:current_user).and_return(user) }

    context 'when reaction with curernt user comment and kind exists' do
      let!(:reaction) { create(:reaction, kind: :like, comment_id: comment.id, user_id: user.id) }

      it 'returns false' do
        allow(helper).to receive_message_chain(:current_user).and_return(user)
        expect(helper.can_react?([comment], comment, :like)).to be false
      end
    end

    context 'when reaction with comment and kind exists but with different user' do
      let!(:reaction) { create(:reaction, kind: :like, comment_id: comment.id, user_id: create(:user).id) }

      it 'returns true' do
        expect(helper.can_react?([comment], comment, :like)).to be true
      end
    end

    context 'when reaction with comment and user exists but with different kind' do
      let!(:reaction) { create(:reaction, kind: :like, comment_id: comment.id, user_id: create(:user).id) }

      it 'returns true' do
        expect(helper.can_react?([comment], comment, :smile)).to be true
      end
    end

    context 'when reaction with kind and user exists but with different comment' do
      let!(:reaction) { create(:reaction, kind: :like, comment_id: create(:comment).id, user_id: create(:user).id) }

      it 'returns true' do
        expect(helper.can_react?([comment], comment, :like)).to be true
      end
    end
  end
end
