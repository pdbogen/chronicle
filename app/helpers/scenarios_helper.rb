module ScenariosHelper
	def sortable( column, title = nil )
		title ||= column.titleize
		link_sort = Array.new( @sort )
		if @sort.include?( column )
			link_sort[ link_sort.index( column ) ] = "rev"+column
			link_to( title, scenario_path( sort: link_sort.join(" ") ) ) + " " + tag( "span", class: "glyphicon glyphicon-arrow-down" )
		elsif @sort.include?( "rev"+column )
			link_sort.delete( "rev"+column )
			link_to( title, scenario_path( sort: link_sort.join(" ") ) ) + " " + tag( "span", class: "glyphicon glyphicon-arrow-up" )
		else
			link_sort.push( column )
			link_to title, scenario_path( sort: link_sort.join( " " ) )
		end
	end
end
