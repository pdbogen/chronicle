Scenario.create( [
	{ name: 'Silent Tide', low_tier_lower: 1, low_tier_upper: 2, high_tier_lower: 4, high_tier_upper: 5, season: 0, episode: 1 },
	{ name: "The Hydra's Fang Incident", low_tier_lower: 1, low_tier_upper: 2, high_tier_lower: 4, high_tier_upper: 5, season: 0, episode: 2 },
	{ name: "Voice in the Void", low_tier_lower: 1, low_tier_upper: 2, mid_tier_lower: 3, mid_tier_upper: 4, high_tier_lower: 6, high_tier_upper: 7, season: 1, episode: 35 },
] )

User.create!( [ { 
	email: "pdbogen-chroniclr@cernu.us",
	password: "2dm37jv7Kf3tzTRk5r5RlrNSDfzero0guQG3XsC1Re8HiD3tvDf2VJnffwXWre8v9cfmlB6TGS3W6iFiTgzaogOKLv2IAyeUevYO",
	username: "pdbogen"
} ] )

User.find_by( username: "pdbogen" ).right << Right.all
