#!/usr/bin/tclsh

set dlcode 0
set dllist [list \
	"linux-vdso.so" \
	"libutil.so" \
	"libresolv.so" \
	"libdl.so" \
	"librt.so" \
	"libm.so" \
	"libstdc++.so" \
	"libgcc_s.so" \
	"libpthread.so" \
	"libc.so" \
	"libcrypt.so" \
	"libfreebl3.so" \
	"libnsl.so" \
	"/lib64/ld-linux-x86-64.so" \
]

proc dlcheck {arg} {
	global dlcode dllist

	set res [exec ldd $arg]
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
