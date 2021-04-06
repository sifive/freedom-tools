#!/usr/bin/tclsh

set dlcode 0
set dllist [list \
	"/System/Library/Frameworks/Hypervisor.framework" \
	"/System/Library/Frameworks/CoreFoundation.framework" \
	"/System/Library/Frameworks/IOKit.framework" \
	"/System/Library/Frameworks/CoreAudio.framework" \
	"/System/Library/Frameworks/Cocoa.framework" \
	"/System/Library/Frameworks/Carbon.framework" \
	"/System/Library/Frameworks/AppKit.framework" \
	"/System/Library/Frameworks/ApplicationServices.framework" \
	"/System/Library/Frameworks/CoreGraphics.framework" \
	"/System/Library/Frameworks/CoreServices.framework" \
	"/System/Library/Frameworks/Foundation.framework" \
	"/usr/lib/libresolv" \
	"/usr/lib/libiconv" \
	"/usr/lib/libc++" \
	"/usr/lib/libSystem" \
	"/usr/lib/libobjc" \
	"/usr/lib/libncurses" \
	"/usr/lib/liblzma" \
]

proc dlcheck {arg} {
	global dlcode dllist

	set res [exec otool -L $arg]
	set lns [split $res "\n"]
	foreach ln $lns {
		set txt [string trim $ln]
		if {[string index $txt end] ne ":"} {
			set fnd 0
			foreach dl $dllist {
				if {[string first $dl $txt] >= 0} {
					set fnd 1
					break
				}
			}
			if {$fnd == 0} {
				set dlcode 1
				puts "  Illegal library used: $txt"
			}
		}
	}
}

foreach arg $argv {
	puts "Checking dynamic library usage for: $arg"
	dlcheck $arg
}

exit $dlcode
