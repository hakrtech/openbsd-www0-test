# Makefile for WWW subdirectory.

all: groups.html support.html

# Build the user groups page.
groups.html:	groups.dat groups.awk groups.skel
		awk -f groups.awk groups.dat > groups-tbl.html
		cpp -P groups.skel > groups.html
		@rm -f groups-tbl.html

# Build the support/consultants page.
support.html:	support.dat support.awk support.skel
		awk -f support.awk support.dat > support-tbl.html
		cpp -P support.skel > support.html
		@rm -f support-tbl.html
