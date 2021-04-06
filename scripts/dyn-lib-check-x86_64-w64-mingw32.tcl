#!/usr/bin/tclsh

# w64_mingw32 are not checked as there are no means to do it on linux
set dlcode 0

foreach arg $argv {
	puts "Checking dynamic library usage for: $arg"
}

exit $dlcode
