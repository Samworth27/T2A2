require 'application_system_test_case'

class ScaffoldsTest < ApplicationSystemTestCase
  setup do
    @scaffold = scaffolds(:one)
  end

  test 'visiting the index' do
    visit scaffolds_url
    assert_selector 'h1', text: 'Scaffolds'
  end

  test 'should create scaffold' do
    visit scaffolds_url
    click_on 'New scaffold'

    click_on 'Create Scaffold'

    assert_text 'Scaffold was successfully created'
    click_on 'Back'
  end

  test 'should update Scaffold' do
    visit scaffold_url(@scaffold)
    click_on 'Edit this scaffold', match: :first

    click_on 'Update Scaffold'

    assert_text 'Scaffold was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Scaffold' do
    visit scaffold_url(@scaffold)
    click_on 'Destroy this scaffold', match: :first

    assert_text 'Scaffold was successfully destroyed'
  end
end
