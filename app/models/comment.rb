class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  after_create_commit :broadcast_chat

  def broadcast_chat
    broadcast_append_to(
      "comments",
      target: "comments",
      partial: "comments/comment",
      locals: { comment: self }
    )
  end
end
