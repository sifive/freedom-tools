#!/usr/bin/tclsh

cd [lindex $argv 0]
set pathmap [dict create]
set rootlen [string length "[pwd]/"]
set res 0

proc checkfiles {rd} {
	global pathmap rootlen res
	
	set fs [lsort [glob -nocomplain -types f "$rd/*"]]
	foreach f $fs {
		set fnc [string tolower [string range $f $rootlen end]]
		if {[dict exists $pathmap $fnc]} {
			puts "Multiple paths with different case exists for: $fnc"
			set res 1
		} else {
#			puts "Checking: $fnc"
		}
		dict set pathmap $fnc 1
	}

	set ds [lsort [glob -nocomplain -types d "$rd/*"]]
	foreach d $ds {
		set dnc [string tolower [string range $d $rootlen end]]
		if {[dict exists $pathmap $dnc]} {
			puts "Multiple paths with different case exists for: $dnc"
			set res 1
		} else {
#			puts "Checking: $dnc"
		}
		dict set pathmap $dnc 1
		checkfiles $d
	}
}

checkfiles [pwd]
exit $res
