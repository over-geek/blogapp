require 'rails_helper'

RSpec.describe 'Visit the user show page', type: :feature do
  before :each do
    @user = User.create(
      name: 'John Doe',
      photo: 'https://randomuser.me/api/portraits/men/1.jpg',
      bio: 'A passionate individual with interesting stories to share.'
    )
    @post1 = Post.create(author: @user, title: 'Post 1', text: 'This is the content of Post 1')
    @post2 = Post.create(author: @user, title: 'Post 2', text: 'This is the content of Post 2')
    @post3 = Post.create(author: @user, title: 'Post 3', text: 'This is the content of Post 3')
    @post4 = Post.create(author: @user, title: 'Post 4', text: 'This is the content of Post 4')
    @post5 = Post.create(author: @user, title: 'Post 5', text: 'This is the content of Post 5')
    @post6 = Post.create(author: @user, title: 'Post 6', text: 'This is the content of Post 6')
  end

  it 'displays user information on the show page' do
    visit user_path(@user)

    expect(page).to have_selector('img[src=\'https://randomuser.me/api/portraits/men/1.jpg\']')
    expect(page).to have_content 'John Doe'
    expect(page).to have_content 'Number of posts: 6'
    expect(page).to have_content 'A passionate individual with interesting stories to share.'
  end

  it 'displays the first 3 posts of the user' do
    visit user_path(@user)

    # Expect the first 3 posts to be displayed
    expect(page).to have_content 'Post 4'
    expect(page).to have_content 'Post 5'
    expect(page).to have_content 'Post 6'

    # Ensure only the three most recent posts are displayed
    expect(page).not_to have_content 'Post 1'
    expect(page).not_to have_content 'Post 2'
    expect(page).not_to have_content 'Post 3'
  end

  # Ensure that user is redirected to post index page to see all posts when see all posts button is clicked
  it 'Asserts that I can see a button that lets me view all of a users posts' do
    visit user_path(@user)

    # Expect to see See All Posts button

    expect(page).to have_content 'See All Posts'

    click_link 'See All Posts'
    expect(page).to have_current_path(user_posts_path(@user))
    expect(page).to have_content 'Post 4'
    expect(page).to have_content 'Post 5'
    expect(page).to have_content 'Post 6'
    expect(page).to have_content 'Post 3'
    expect(page).to have_content 'Post 2'
    expect(page).to have_content 'Post 1'
  end
end
