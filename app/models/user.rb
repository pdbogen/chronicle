class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :right
  has_many :play_sessions
  has_many :scenarios, through: :play_sessions
  has_many :characters

  def has_right?( right_name )
    right.where( right_name: right_name ).any?
  end
end
