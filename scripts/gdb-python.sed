s/ldirname .python_libdir..c_str...,/getenv("FREEDOMPYTHONHOME"),/
s/Py_SetProgramName..progname.release/Py_SetPythonHome \(getenv("FREEDOMPYTHONHOME")\)\; Py_SetProgramName \(progname\.release/
