require 'rails_helper'

feature 'An admin rejects a place update' do
  scenario 'which has to be in pending state' do
    active = create(:place_update, :active)
    login_as(create(:admin))

    visit rails_admin.edit_path(model_name: 'PlaceUpdate', id: active.id)

    expect(page).to_not have_link(t('admin.actions.reject.menu'))
  end

  scenario 'by clicking on the reject link' do
    pending = create(:place_update)
    login_as(create(:admin))

    visit rails_admin.edit_path(model_name: 'PlaceUpdate', id: pending.id)
    click_link(t('admin.actions.reject.menu'))

    pending.reload
    expect(pending).to be_rejected
  end
end
