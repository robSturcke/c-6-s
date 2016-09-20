namespace :posts do
  desc "TODO"
  task delete_30_days_old: :environment do
    Post.where(['created_at < ?', 30.minuts.ago]).destroy_all
  end
end
