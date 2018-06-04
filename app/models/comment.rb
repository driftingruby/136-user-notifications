class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_commit :create_notifications, on: :create

  private

  def create_notifications
    Notification.create do |notification|
      notification.notify_type = 'post'
      notification.actor = self.user
      notification.user = self.post.user
      notification.target = self
      notification.second_target = self.post
    end
  end
end
