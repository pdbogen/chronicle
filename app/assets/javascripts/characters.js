function addLevel( button ) {
	var classname = button.dataset[ "classname" ];
	var container = document.getElementById( "character_levels" );
	var current = $.parseJSON( container.value );
	if( current[ classname ] ) {
		current[ classname ][ "levels" ]++;
	} else {
		current[ classname ] = { levels: 1, pretty: button.dataset[ "prettyname" ], glyph: button.dataset[ "glyph" ] };
	}
	container.value = JSON.stringify( current );
	rerenderLevels();
}

function rerenderLevels() {
	var lc = $("#levelContainer");
	lc.empty();
	var container = document.getElementById( "character_levels" );
	var current = $.parseJSON( container.value );
	if( Object.keys( current ).length == 0 ) {
		lc.append( $("<span class='instruction glyphicon glyphicon-chevron-left'></span>") )
		  .append( $("<span class='instruction text'>Pick some.</span>" ) );
	} else {
		for( var c in current ) {
			var div = $("<div>").
				addClass( "btn btn-primary col-md-4 levelBtn" ).
				text( current[ c ][ "pretty" ] + " " + current[ c ][ "levels" ] ).
				append( "<span class='glyphicon glyphicon-remove'></span>" ).
				prepend( "<span class='glyphicon glyphicon-" + current[ c ][ "glyph" ] + "'></span>" ).
				data( "classname", c ).
				click( removeLevel );
			lc.append( div );
			lc.append( " " );
		}
		lc.append( "<div class='clearfix'></div>" );
	}
}

function removeLevel() {
	var classname = $(this).data( "classname" );
	var container = document.getElementById( "character_levels" );
	var current = $.parseJSON( container.value );
	if( current[ classname ] ) {
		current[ classname ][ "levels" ]--;
		if( current[ classname ][ "levels" ] == 0 ) {
			delete current[ classname ];
		}
	}
	container.value = JSON.stringify( current );
	rerenderLevels();
}

function ready() {
	var cl = document.getElementById( "character_levels" );
	var pl = document.getElementById( "prefill_levels" );
	if( cl ) {
		if( pl ) {
			cl.value = pl.value;
		} else {
			cl.value = "{}";
		}
		rerenderLevels();
	}
}

$( document ).ready(ready);
$( document ).on('page:load', ready);
