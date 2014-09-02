require 'rails_helper'

RSpec.describe( CharactersController, :type => :controller ) do
	def generate_character( options={} )
		classes = options[ :classes ] || { :wizard => 1 }
		char = { :name => options[ :name ] || "rincewind", :levels => {} }
		classes.each do |c,n|
			char[ :levels ][ c ] = { :levels => n }
		end
		return char
	end

	describe 'GET new' do
		context "without session prefills" do
			it "initializes character, errors, and errorfields to empty" do
				get :new
				expect( assigns( :character ) ).to eq( {} )
				expect( assigns( :errors ) ).to eq( [] )
				expect( assigns( :errorfields ) ).to eq( {} )
			end
			it "sets valid character from session to instance variable" do
				session[ :character ] = generate_character
				get :new
				expect( assigns( :character ) ).to eq( generate_character )
				expect( session[ :character ] ).to eq( nil )
				expect( assigns( :errors ) ).to eq( [] )
				expect( assigns( :errorfields ) ).to eq( {} )
			end
			it "propagates errors from session into instance variable" do
				session[ :errors ] = [ "fail!" ]
				get :new
				expect( assigns( :character ) ).to eq( {} )
				expect( assigns( :errors ) ).to eq( [ "fail!" ] )
				expect( session[ :errors ] ).to eq( nil )
				expect( assigns( :errorfields ) ).to eq( {} )
			end
		end
		context "with error prefill" do
			before do
				session[ :errors ] = [ "fail!" ]
			end
			it "initializes character to prefille, errors and errorfields to empty" do
				get :new
				expect( assigns( :character ) ).to eq( {} )
				expect( assigns( :errors ) ).to eq( [ "fail!" ] )
				expect( session[ :errors ] ).to eq( nil )
				expect( assigns( :errorfields ) ).to eq( {} )
			end
		end
	end
end
