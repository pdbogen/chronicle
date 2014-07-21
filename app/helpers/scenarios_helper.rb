module ScenariosHelper
	def sortable( column, title = nil )
		title ||= column.titleize
		link_sort = Array.new( @sort )
		if @sort.include?( column )
			link_sort[ link_sort.index( column ) ] = "rev"+column
			link_to( title, scenario_path( filters: @filters, sort: link_sort ) ) + " " + tag( "span", class: "glyphicon glyphicon-arrow-down" )
		elsif @sort.include?( "rev"+column )
			link_sort.delete( "rev"+column )
			link_to( title, scenario_path( filters: @filters, sort: link_sort ) ) + " " + tag( "span", class: "glyphicon glyphicon-arrow-up" )
		else
			link_sort.push( column )
			link_to title, scenario_path( filters: @filters, sort: link_sort )
		end
	end

    def levels
        min_level = Scenario.minimum( :low_tier_lower )
        max_level = Scenario.maximum( :high_tier_upper )
        (min_level..max_level).to_a
    end

	def filterable( column, title=nil )
		title ||= column.titleize
		if column == "level"
			values_block = safe_join(
				levels().collect { |value|
					content_tag( :li, :role => "presentation" ) {
						filterable_link( "level", value, 1 )
					}
				}
			)
		else
			values_block = safe_join(
				Scenario.group( column ).count().collect { |value,count|
					content_tag( :li, :role => "presentation" ) {
						filterable_link( column, value, count )
					}
				}
			)
		end
		content_tag :div, :class => "dropdown" do
			safe_join [
				content_tag( :button, :class => "btn dropdown-toggle", :id => column+"Filter", "data-toggle" => "dropdown" ) {
					safe_join [
						content_tag( :span, title + " ", :class => "dropdownText" ).html_safe,
						content_tag( :span, "", :class => :caret ).html_safe
					]
				},
				content_tag( :ul, :class => "dropdown-menu", :role => "menu", "aria-labelledby" => column+"Filter" ) {
					( in_filter?( column, :all ) ?
						"" :
						content_tag( :li, :role => "presentation" ) {
							link_to( "show all", scenario_path( sort: @sort, filters: build_filter( column, :all ) ) )
						}
					).html_safe + values_block
				}
			]
		end
	end

	def filterable_link( column, value, count )
		content_tag( :a,
		             :role => "menuitem",
		             :href => scenario_path( sort: @sort, filters: build_filter( column, value ) ),
		) {
			safe_join( [
				in_filter?( column, value ) ?
					content_tag( :span, "", :class => "glyphicon glyphicon-check" ).html_safe :
					content_tag( :span, "", :class => "glyphicon glyphicon-unchecked" ).html_safe ,
				" " + value.to_s
			] )
		}
	end

	def build_filter( column, value )
		if value == :all
			return @filters.reject { |k,v| k == column }
		end

		if @filters[ column ].nil?
			if column == "level"
				base_set = levels()
			else
				base_set = Scenario.group( column ).pluck( column )
			end

			@filters.merge( column => (base_set & [ value ]).each{ |v| v.to_s } )
		elsif in_filter?( column, value )
			if @filters[ column ].length == 1
				Hash.new( @filters ).delete( column )
			else
				@filters.merge( column => @filters[ column ] - [ value.to_s ] )
			end
		else
			@filters.merge( column => @filters[ column ] | [ value.to_s ] )
		end
	end

	def in_filter?( column, value )
		puts "%p contains %p? (%p => %p)" % [ column, value, @filters, @filters[ column ] ]
		if value == :all
			@filters[ column ].nil? or @filters[ column ].empty?
		else
			not @filters[ column ].nil? and
			not @filters[ column ].empty? and
			@filters[ column ].include?( value.to_s )
		end
	end

	def filter_breadcrumbs
		safe_join(
			@filters.collect do |k,v|
				safe_join [
					link_to( scenario_path( filters: build_filter( k, :all ), sort: @sort ), class: "btn btn-info btn-mini" ) {
						safe_join [
							content_tag( :i, :class => "glyphicon glyphicon-remove" ) {}.html_safe,
							" ",
							k.titleize,
							": ",
							v.join( ", " )
						]
					}.html_safe,
					"&nbsp;".html_safe
				]
			end
		)
	end

	def filter_breadcrumb
#		concat link_to( nil, class: "btn btn-info btn-mini" ) {
#			safe_join [
#				content_tag( :i, :class => "glyphicon glyphicon-remove" ).html_safe,
#				" ",
#				f[0].titleize
#			]
#		})
	end
end
