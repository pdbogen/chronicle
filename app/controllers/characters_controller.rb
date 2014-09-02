require 'json'

class CharactersController < ApplicationController
	before_filter :check_name, :check_levels, :check_errors, :only => :create

	def index; end

	def show; end

	def new
		@character = session[ :character ] || {}
		@errors = session[ :errors ] || []
		@errorfields = session[ :errorfields ] || {}
		session.delete( :character )
		session.delete( :errors )
		session.delete( :errorfields )
	end

	def create
		puts "%p" % params
		redirect_to :characters
	end

private
	def check_name
		if params[ :character ][ :name ].empty?
			report_error( "I asked for your name, Pathfinder.", :name )
		end
	end

	def check_levels
		levels = []

		begin
			levels = JSON.parse( params[ :character ][ :levels ] )
		rescue
			report_error( "An error occurred saving the requested levels. What have you done?", :levels )
		end

		@levels = {}
		if levels.empty?
			report_error( "Surely you've been confirmed already. What are you trained in?", :levels )
		end
		levels.each do | classname, details |
			clean = true

			if not Classes.include?( classname.to_sym )
				clean = false
				report_error( "And what on Golarion is a %p?" % [ classname ], :levels )
			end

			if not (/\A([1-9]|1[0-9]|20)\Z/ =~ details[ 'levels' ].to_s)
				clean = false
				report_error( "You're trying my patience, Pathfinder. What are your levels?", :levels )
			end

			if clean
				@levels[ classname ] = details[ 'levels' ]
			end
		end
	end

	def check_errors
		if session[ :errors ] and not session[ :errors ].empty?
			session[ :character ] = params[ :character ]
			levels_hash = {}
			@levels.each { |c,l|
				levels_hash[ c ] = { levels: l, pretty: c.titleize, glyph: Classes[ c.to_sym ] }
			}
			session[ :character ][ 'levels' ] = JSON.generate( levels_hash )
			redirect_to :back
		end
	end

	def report_error( error, field )
		session[ :errors ] ||= []
		session[ :errorfields ] ||= {}
		session[ :errors ].push( error );
		session[ :errorfields ][ field ] = true
	end
end
