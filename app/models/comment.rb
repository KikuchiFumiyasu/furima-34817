class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user

  with_options presence: true do
    validates :text
    validates :user_id
    validates :item_id
  end
end
