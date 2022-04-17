# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  scenario 'User creates a new posts' do
    login_as(create(:user), scope: :user)

    visit '/posts/new'

    fill_in 'Title', with: 'Post Title'
    fill_in 'Description', with: 'Post Description'

    click_button 'Create Post'

    expect(page).to have_text('Post Title')
    expect(page).to have_text('Post Description')
    expect(page).to have_text('Post was successfully created.')
  end
end
