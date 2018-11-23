json.array! @notifications do |notification|
  # json.recipient notification.recipient
  json.actor notification.actor.username
  json.action notification.action
  json.notifiable notification.notifiable
  json.url chat_room_path(notification.notifiable)
end
