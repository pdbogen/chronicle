User.create!( [ { 
	email: "pdbogen-chroniclr@cernu.us",
	password: "2dm37jv7Kf3tzTRk5r5RlrNSDfzero0guQG3XsC1Re8HiD3tvDf2VJnffwXWre8v9cfmlB6TGS3W6iFiTgzaogOKLv2IAyeUevYO",
	username: "pdbogen"
} ] )

User.find_by( username: "pdbogen" ).right << Right.all
