require 'rails_helper'

feature 'A user lists places' do
  scenario 'by clicking on the navigation link' do
    create_list(:place, 3, :active)

    visit root_path
    click_link 'Tous les lieux'

    expect(page).to have_content('3 lieux')
  end

  scenario 'and views all places details' do
    place = create(:place, :active)

    visit places_path

    expect(page).to have_content(place.name)
    expect(page).to have_content(place.url)
    expect(page).to have_content(t("kinds.codes.#{place.kind}"))
  end

  scenario 'and navigates between pages' do
    create_list(:place, 30, :active)
    last_place = create(:place, :active, updated_at: 1.day.ago)

    visit places_path
    click_link 'Suivante'

    expect(page).to have_content(last_place.name)
  end
end
