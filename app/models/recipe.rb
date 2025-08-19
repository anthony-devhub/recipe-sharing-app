class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_categories, dependent: :destroy
  has_many :categories, through: :recipe_categories

  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :recipe_tags, allow_destroy: true
  accepts_nested_attributes_for :recipe_categories, allow_destroy: true

  has_one_attached :photo # Active Storage

  validates :title, :instructions, presence: true
  validate :acceptable_photo

  after_commit :process_photo, on: [ :create, :update ], if: :photo_changed?

  private

  def process_photo
    ProcessRecipePhotoJob.perform_later(id) if photo.attached?
  end

  def photo_changed?
    photo.attachment&.blob&.saved_changes?
  end

  def acceptable_photo
    return unless photo.attached?

    unless photo.blob.byte_size <= 10.megabyte
      errors.add(:photo, "is too large (max 10MB)")
    end

    acceptable_types = [ "image/jpeg", "image/png", "image/webp" ]
    unless acceptable_types.include?(photo.content_type)
      errors.add(:photo, "must be a JPEG, PNG, or WEBP")
    end
  end
end
