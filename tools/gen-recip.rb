#
# program to generate table of reciprocals
# Convergence
#
# $Id: gen-recip.rb,v 1.1 2002/09/16 01:30:50 tek Exp $
#

l = ".hword "
2.upto(255) do |i|
    l += sprintf("0x%x", (65536.0/i).to_i)
    if l.length > 72
	puts l
	l = ".hword "
    else
	l += ", "
    end
end
puts l

# EOF gen-recip.rb
