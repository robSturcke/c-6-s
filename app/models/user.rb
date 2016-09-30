class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validate :validate_invite, :on => :create
  attr_accessor :invite

  has_many :posts

  belongs_to :role
  before_create :set_default_role

  def validate_invite
    if self.invite != "technodromedestiny"
      self.errors[:base] << "The invite code you've entered is incorrect."
    end
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end
end
