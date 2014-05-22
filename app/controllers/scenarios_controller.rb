class ScenariosController < ApplicationController
	def show
		@sort = []
		if params[ :sort ]
			@sort = params[ :sort ].split & (
				[ "season", "episode", "name", "low_tier_lower", "mid_tier_lower", "high_tier_lower" ] |
				[ "revseason", "revepisode", "revname", "revlow_tier_lower", "revmid_tier_lower", "revhigh_tier_lower" ]
			)
			@english_sort = @sort.map do |c|
				col = c
				if c[0,3] == "rev"
					col = c[3,c.length]
				end
				case col
				when "low_tier_lower"
					col = "Low Tier"
				when "mid_tier_lower"
					col = "Middle Tier"
				when "high_tier_lower"
					col = "High Tier"
				end
				col.titleize + (c[0,3] == "rev"?" (reverse)":"")
			end
		end
		@order = @sort.map do |c|
				if c[0,3] == "rev"
					c[3,c.length] + " DESC"
				else
					c
				end
		end
		@scenarios = Scenario.order( @order.join( ", " ) ).all
	end
end
