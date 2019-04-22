class Post < ApplicationRecord
  after_create :notify_pushder, on: :create
  has_many :likes

  def notify_pushder
    Pusher.trigger('feed', 'new-post', self.as_json(include: :likes))
  end
end
