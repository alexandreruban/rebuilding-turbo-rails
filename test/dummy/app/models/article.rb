class Article < ApplicationRecord
  validates :content, presence: true

  after_create_commit { broadcast_prepend_to "articles" }
  after_update_commit { broadcast_replace_to "articles" }
  after_destroy_commit { broadcast_remove_to "articles" }
end
