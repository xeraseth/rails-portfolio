require "test_helper"

feature "Creating a comment" do
  scenario "submit form data to create a new comment as an anonymous user" do
    post_comment('author')

    page.text.must_include "Comment was successfully created. It will be published once an editor approves it."
  end

  scenario "submit form data to create a new comment as an editor user" do
    post_comment('editor')

    page.text.must_include "Comment was successfully created."
    page.text.must_include comments(:comment1).content
  end

  scenario "submit form data to create a new comment as an editor user on a project" do
    login
    visit project_path(projects(:portfolio))
    fill_in "Comment", with: comments(:comment1).content

    # When I submit the form
    click_on "Submit Comment"

    page.text.must_include "Comment was successfully created."
    page.text.must_include comments(:comment1).content
  end
end
