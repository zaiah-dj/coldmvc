#Converts the docblocks to HTML
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
