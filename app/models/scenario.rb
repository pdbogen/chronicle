class Scenario < ActiveRecord::Base
	has_many :play_sessions
	has_many :user, through: :play_sessions
end
