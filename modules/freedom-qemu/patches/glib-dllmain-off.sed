s/if defined (G_OS_WIN32)/if defined \(G_OS_WIN32_NATIVE\)/
s/G_DEFINE_CONSTRUCTOR(glib_init_ctor)/HMODULE glib_dll\; G_DEFINE_CONSTRUCTOR\(glib_init_ctor\)/
