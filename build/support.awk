#!/usr/bin/nawk -f

# Called from makefile to convert from support.dat to ../support.html

# convert data like this (order doesn't matter except 0 at front)
# 0
# C Erewhon
# P Ontario
# T Dictionopolis
# A R R # 1
# Z L0N 1P0
# O Consultant
# I Ian F. Darwin
# M ian@ougge.erewhon
# U http://www.darwinsys.com
# N Author of lots of kool stuff.

# into HTML to make nice neat tables.


/^#/ { next; }

$1 == "0" {
	if (country == "" && prov == "")
		next;
	dump();
	reset();
	next;
	}

$1 == "C" { country = substr($0, 3);
	if (country == "USA")
		country = "United States"
	if (country != oldCountry) {
		print "<tr><td bgcolor=\"#99FFFF\" colspan=\"2\" align=\"center\">"
		print "<b>" country "</b>"
		print "</td></tr>"
	 }
	oldCountry = country
	next
}
$1 == "P" { prov = substr($0, 3); next }
$1 == "T" { city = substr($0, 3); next }
$1 == "A" { addr = substr($0, 3); next }
$1 == "Z" { zip = substr($0, 3); next }
$1 == "O" { org = substr($0, 3); next }
$1 == "I" { indv = substr($0, 3); next }
$1 == "B" { phone = substr($0, 3); next }
$1 == "F" { fax = substr($0, 3); next }
$1 == "M" { email = substr($0, 3); next }
$1 == "U" { url = substr($0, 3); next }
$1 == "N" { note = substr($0, 3); next }

# left over - must be part of note?
	{
	note = note "\n" $0
	next
	}

function dump() {
	print "<tr>"
	print "<td bgcolor=\"White\">" 
		if (indv != "")
			print "<i>" indv "</i><br />" 
		if (org != "")
			print "<b>" org "</b><br />" 
		if (addr != "")
			print addr "<br />"
		if (city != "") {
			print city
			if (prov != "")
				print ", " prov
			if (zip != "")
				print " " zip
			print "<br />"
		}
		if (phone != "")
			print "Phone: " phone "<br />" 
		if (fax != "")
			print "FAX: " fax "<br />"
		if (email != "")
			print "Email: <a href=\"mailto:" email "\">" email "</a>" "<br />"
		if (url != "")
			print "URL: <a href=\"" url "\">" url "</a>"
		print "</td>"
	print "	<td>" note
	print "</td></tr>"
}

function reset() {
	prov = ""
	city = ""
	addr = ""
	zip = ""
	org = ""
	indv = ""
	email = ""
	phone = ""
	fax = ""
	url = ""
	note = ""
}

END {
	dump();		# don't forget the last guy!
}
