class Like < ApplicationRecord
  after_save :notify_pusher, on: :create
  belongs_to :post

  def notify_pusher
    Pusher.trigger('feed', 'new-like', self.post.as_json(include: :likes))
  end
end
