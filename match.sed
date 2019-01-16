# -----------------------------------------------
# match.sed
# ---------
#
# @author
# 	Antonio R. Collins II (rc@tubularmodular.com, ramar.collins@gmail.com)
# @end
# 
# @copyright
# 	Copyright 2016-Present, "Tubular Modular"
# 	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
# @end
# 
# @summary
#		Converts the docblocks to HTML
# @end
# -----------------------------------------------
{
	s;^\t;;
	
	#...
	/^[public|private].*function [_a-zA-Z\s].*(/,/[^\{]/ {
	#/^[public|private].*function [_a-zA-Z\s].*(/ , /)/ {
		s;\n;;
		p
	}
	 
	#...
	/@title/ {
		s;//@title: \(.*\);<h2>\1</h2>;
		p
	}
	/@[body|args]/,/@end/ {
		s;//@args :;<p>; 
		s;//@body :;<p>; 
		s;//@end;</p>; 
		s;//;;
		p
	}
}
