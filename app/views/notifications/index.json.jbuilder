json.array! @notifications do |notification|
  json.id notification.id
  #json.recipient notification.recipient
  json.unread !notification.read_at?
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable do #notification.notifiable
    json.type "a chat with you"
  end
  json.url chat_room_path(notification.notifiable_id)
end
