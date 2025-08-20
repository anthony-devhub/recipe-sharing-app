require 'rails_helper'

RSpec.describe ProcessRecipePhotoJob, type: :job do
  include ActiveJob::TestHelper

  let(:recipe) { create(:recipe) }

  before do
    # Attach a test image
    recipe.photo.attach(
      io: File.open(Rails.root.join("spec/fixtures/valid_image.jpg")),
      filename: "test_image.jpg",
      content_type: "image/jpeg"
    )
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe "#perform" do
    it "processes the photo variants" do
      expect(recipe.photo).to be_attached
      ProcessRecipePhotoJob.perform_now(recipe.id)
    end

    it "does nothing if photo is not attached" do
      recipe.photo.purge
      expect { ProcessRecipePhotoJob.perform_now(recipe.id) }.not_to raise_error
    end
  end

  describe "enqueuing" do
    it "queues the job" do
      expect {
        ProcessRecipePhotoJob.perform_later(recipe.id)
      }.to have_enqueued_job(ProcessRecipePhotoJob).with(recipe.id).on_queue("default")
    end
  end
end
