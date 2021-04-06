#!/usr/bin/tclsh

cd [lindex $argv 0]
set pathmax 200
set rootlen [string length "[pwd]/"]
set res 0

set PACKAGE_HEADING [string length [lindex $argv 1]]
set ORIGINAL_VERSION [string length [lindex $argv 2]]
set FREEDOM_TOOLS_ID [string length [lindex $argv 3]]
set pathmax [expr ${pathmax}-${PACKAGE_HEADING}-${ORIGINAL_VERSION}-${FREEDOM_TOOLS_ID}-2]

proc checkfiles {rd} {
	global pathmax rootlen res

	set fs [lsort [glob -nocomplain -types f "$rd/*"]]
	foreach f $fs {
		set str [string range $f $rootlen end]
		set len [string length $str]
		if {$len > $pathmax} {
			puts "Path exceeds maximum allowed length: \"$str\" has length $len larger than $pathmax"
			set res 1
		} else {
#			puts "Checking: \"$str\" has length $len with max $pathmax"
		}
	}

	set ds [lsort [glob -nocomplain -types d "$rd/*"]]
	foreach d $ds {
		set str [string range $d $rootlen end]
		set len [string length $str]
		if {$len > $pathmax} {
			puts "Path exceeds maximum allowed length: \"$str\" has length $len larger than $pathmax"
			set res 1
		} else {
#			puts "Checking: \"$str\" has length $len with max $pathmax"
		}
		checkfiles $d
	}
}

checkfiles [pwd]
exit $res
