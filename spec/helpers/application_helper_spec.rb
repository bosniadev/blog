# frozen_string_literal: true

require 'rails_helper'

describe ApplicationHelper do
  describe '#can_edit?' do
    let(:user) { create(:user) }
    before { allow(helper).to receive_message_chain(:current_user).and_return(user) }

    context 'when comment user is the same as current user' do
      let!(:comment) { create(:comment, user_id: user.id) }

      it 'returns true' do
        allow(helper).to receive_message_chain(:current_user).and_return(user)
        expect(helper.can_edit?(comment)).to be true
      end
    end

    context 'when comment user is not the current user' do
      let!(:comment) { create(:comment, user_id: create(:user).id) }

      it 'returns false' do
        expect(helper.can_edit?(comment)).to be false
      end
    end
  end

  describe '#can_delete?' do
    let(:user) { create(:user) }
    before { allow(helper).to receive_message_chain(:current_user).and_return(user) }

    context 'when comment user is the same as current user' do
      let!(:comment) { create(:comment, user_id: user.id) }

      it 'returns true' do
        allow(helper).to receive_message_chain(:current_user).and_return(user)
        expect(helper.can_edit?(comment)).to be true
      end
    end

    context 'when comment user is not the current user' do
      let!(:comment) { create(:comment, user_id: create(:user).id) }

      it 'returns false' do
        expect(helper.can_edit?(comment)).to be false
      end
    end
  end
end
