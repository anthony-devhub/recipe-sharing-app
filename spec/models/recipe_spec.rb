require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create(:user) }
  let(:recipe) { build(:recipe, user: user) }

  # Associations
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_ingredients).dependent(:destroy) }
    it { should have_many(:ingredients).through(:recipe_ingredients) }
    it { should have_many(:recipe_categories).dependent(:destroy) }
    it { should have_many(:categories).through(:recipe_categories) }
    it { should have_many(:recipe_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:recipe_tags) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one_attached(:photo) }
  end

  # Nested attributes
  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:recipe_ingredients).allow_destroy(true) }
    it { should accept_nested_attributes_for(:recipe_tags).allow_destroy(true) }
    it { should accept_nested_attributes_for(:recipe_categories).allow_destroy(true) }
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:instructions) }

    context 'with photo validation' do
      let(:valid_image) { fixture_file_upload('spec/fixtures/valid_image.jpg', 'image/jpeg') }
      let(:large_image) { fixture_file_upload('spec/fixtures/large_image.png', 'image/jpeg') }
      let(:invalid_file) { fixture_file_upload('spec/fixtures/invalid_file.txt', 'text/plain') }

      it 'accepts valid image files' do
        recipe.photo.attach(valid_image)
        expect(recipe).to be_valid
      end

      it 'rejects files larger than 10MB' do
        recipe.photo.attach(large_image)
        expect(recipe).not_to be_valid
        expect(recipe.errors[:photo]).to include('is too large (max 10MB)')
      end

      it 'rejects invalid file types' do
        recipe.photo.attach(invalid_file)
        expect(recipe).not_to be_valid
        expect(recipe.errors[:photo]).to include('must be a JPEG, PNG, or WEBP')
      end
    end
  end

  # Callbacks
  describe 'callbacks' do
    describe '#process_photo' do
      let(:recipe) { create(:recipe) }
      let(:new_photo) { fixture_file_upload('spec/fixtures/another_image.jpg', 'image/jpeg') }

      it 'processes photo when attached' do
        expect {
          recipe.photo.attach(new_photo)
        }.to have_enqueued_job(ProcessRecipePhotoJob).with(recipe.id)
      end
    end
  end
end
