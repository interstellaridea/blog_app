require 'rails_helper'

RSpec.feature "Adding Reviews to Articles" do 
	before do 
		@john = User.create(email: "john@test.com", password: "password")
		@fred = User.create(email: "fred@test.com", password: "password")

		@article = Article.create(title: "This is the Article", body: "The body of the article is here.", user: @john)
	end

	scenario "permits a signed use to write a review" do 
		login_as(@fred)

		visit "/"
		click_link @article.title
		fill_in "New Comment", with: "An awesome article"
		click_button "Add Comment"


		expect(page).to have_content("Comment has been created")
		expect(page).to have_content("An awesome article")
		expect(current_path).to eq(article_path(@article.comments.last.id))
	end


end