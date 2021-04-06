#!/usr/bin/tclsh

set PACKAGE_WORDING [lindex $argv 0]
set PACKAGE_HEADING [lindex $argv 1]
set ORIGINAL_VERSION [lindex $argv 2]
set FREEDOM_TOOLS_ID [lindex $argv 3]
set res 0

proc check_syntax {exp val txt} {
	global res
	if {![regexp $exp $val]} {
		puts "\"$val\" does not match syntax \"$exp\" for $txt"
		set res 1
	} else {
#		puts "\"$val\" does match syntax \"$exp\" for $txt"
	}
}

check_syntax {^[0-9a-zA-Z_\-\.\ ]+$} $::PACKAGE_WORDING "PACKAGE_WORDING"
check_syntax {^[0-9a-z_\-\.]+$} $::PACKAGE_HEADING "PACKAGE_HEADING"
check_syntax {^[0-9]+\.[0-9]+\.[0-9]+$} $::ORIGINAL_VERSION "ORIGINAL_VERSION"
check_syntax {^[0-9a-z_\-\.]+$} $::FREEDOM_TOOLS_ID "FREEDOM_TOOLS_ID"

exit $res
