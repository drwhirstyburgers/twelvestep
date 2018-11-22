class MessagesController < ApplicationController
  after_create_commit { notify }

  private

  def notify
    Notification.create(event: "New Notification")
  end
end
