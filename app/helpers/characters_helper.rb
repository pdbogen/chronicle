module CharactersHelper
	def class_button( class_name, glyph )
		safe_join( [
			content_tag( :button, safe_join( [
				content_tag( :span, "", class: "glyphicon " + glyph ),
				tag( :br ),
				class_name.capitalize
			] ), { class: "btn btn-large classbtn btn-primary", :onclick => "addLevel( this );", :data => { :classname => class_name, :prettyname => class_name.to_s.titleize, :glyph => glyph } } )
		] )
#	concat safe_join( Classes.collect { |c, details|
#		c.capitalize.to_s + content_tag( :br )
#	})
	end
end
