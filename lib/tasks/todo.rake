namespace :todo do
  desc "delete chat rooms after 24 hours"
  task delete_chats: :environment do
    ChatRoom.where("created_at <= ?", Time.now - 1.days).destroy_all
  end

end
