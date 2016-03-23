require 'rails_helper'

feature 'A user views a place' do
  scenario 'by clicking on the place name from the search results' do
    place = create(:place, :active)

    visit places_path
    click_link place.name

    expect(page).to have_content(place.name)
  end

  scenario 'with all its attributes' do
    place = create(:place, :active)

    visit place_path(place)

    expect(page).to have_content(place.name)
    expect(page).to have_content(place.url)
    expect(page).to have_content(place.city)
    expect(page).to have_content(place.description)
    expect(page).to have_link('Twitter', href: "http://twitter.com/#{place.twitter_name}")
  end

  scenario 'without a twitter link displayed' do
    place = create(:place, :active, twitter_name: nil)

    visit place_path(place)

    expect(page).to_not have_link('Twitter')
  end
end