namespace :remove do
  desc "Removes all posts > 30 mintues old"
  task :old_posts => :environment do
    posts = Post.where("created_at <= ?", Time.now - 30.minutes)
    posts.destroy_all
  end
end
