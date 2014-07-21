class ScenariosController < ApplicationController
	before_filter :parse_filters
	before_filter :parse_sort
	def show
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
		@order = @sort.map do |c|
				if c[0,3] == "rev"
					c[3,c.length] + " DESC"
				else
					c
				end
		end
		@scenarios = Scenario.order( @order.join( ", " ) ).where( @sqlfilter ).all
		puts "%p" % [ @scenarios ]
	end

	private

	def parse_sort
		@sort = []
		if not params[ :sort ].nil?
			@sort = params[ :sort ] & (
				[ "season", "episode", "name", "low_tier_lower", "mid_tier_lower", "high_tier_lower" ] |
				[ "revseason", "revepisode", "revname", "revlow_tier_lower", "revmid_tier_lower", "revhigh_tier_lower" ]
			)
		end
	end

	def parse_filters
		@filters = Hash.new
		superfilter = [ ]
		if not params[ :filters ].nil? and params[ :filters ].is_a?(Hash)
			params[ :filters ].each { |k,v|
				if k == "level" and v.is_a?(Array)
					@filters[k] = v
					subfilter = Array.new
					v.each { |level|
						next unless /\A([0-9]+)\Z/.match(level)
						subfilter << "( low_tier_lower <= #{level} AND high_tier_upper >= #{level} )"
					}
					superfilter << "(" + subfilter.join( " OR " ) + ")"
				else
					if Scenario.column_names().include?( k ) and v.is_a?(Array)
						@filters[k] = v
						subfilter = Array.new
						v.each { |value|
							subfilter << "#{k} = #{Scenario.sanitize( value )}"
						}
						superfilter << "(" + subfilter.join( " OR " ) + ")"
					end
				end
			}
		end
		@sqlfilter = (superfilter - [ "()" ] ).join( " AND " )
		puts @sqlfilter
	end
end
