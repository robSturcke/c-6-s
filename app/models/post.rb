class Post < ActiveRecord::Base
  belongs_to :user

  def post_time_out
    create_date = created_at.to_date
    (create_date + 45.minutes - create_date).to_i
  end
  
end
