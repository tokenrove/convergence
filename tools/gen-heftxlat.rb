#
# program to generate table of hefts to lbs/3
# Convergence
#
# $Id: gen-heftxlat.rb,v 1.1 2002/12/09 13:09:38 tek Exp $
#

l = ".hword "
0.upto(254) do |i|
    l += sprintf("0x%x", (3*(1.04**i.to_f)).to_i)
    if l.length > 72
	puts l
	l = ".hword "
    else
	l += ", "
    end
end
puts l

# EOF gen-heftxlat.rb
