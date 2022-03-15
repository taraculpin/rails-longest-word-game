require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  VOWELS = %w[A E I O U Y]

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid." do
    visit new_url
    fill_in "word", with: "historically"
    click_on "Go!"
    assert_equal score_path, page.current_path
    assert_text "This word can't be made from the grid"
  end

  test "You can fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word." do
    visit new_url
    letter = page.first('li').text
    fill_in "word", with: "#{letter}"
    click_on "Go!"
    assert_equal score_path, page.current_path
    assert_text "#{letter} is not a word"
  end

  test "You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a “Congratulations” message." do
    visit new_url
    fill_in "word", with: "a"
    click_on "Go!"
    assert_equal score_path, page.current_path
    assert_text "Congratulations"

  end

end
