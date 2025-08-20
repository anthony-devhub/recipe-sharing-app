require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:comment) { build(:comment, user: user, recipe: recipe) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:recipe) }
  end

  describe "callbacks" do
    describe "#broadcast_chat" do
      let(:comment) { create(:comment, user: user, recipe: recipe) }

      it "broadcasts to the correct stream" do
        expect(Turbo::StreamsChannel).to receive(:broadcast_append_to).with(
          "comments",
          target: "comments",
          partial: "comments/comment",
          locals: { comment: comment }
        )

        comment.broadcast_chat
      end
    end
  end
end
