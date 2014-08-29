class UsersController < ApplicationController
	def show
		@user = User.find( params[ :id ] )
	end

	def update
		@user = User.find( params[ :id ] )
		if( params[ :id ] != current_user[ :id ] and not current_user.has_right?( "Manage Users" ) ) then
			fail( "You are not allowed to modify that user. What're you trying to pull?" ) and return
		end

		if not params[ :user ][ :pfs_number ] =~ /\A[0-9]+\Z/ then
			fail( "PFS number should be a number. Come on." ) and return
		end

		@user.pfs_number = params[ :user ][ :pfs_number ]
		@user.save
		succeed( "Great success!" ) and return
	end

	private

	def fail( message )
		session[ :message ] = message
		redirect_to :back
	end

	def succeed( message )
		session[ :toast ] = message
		redirect_to :back
	end
end
