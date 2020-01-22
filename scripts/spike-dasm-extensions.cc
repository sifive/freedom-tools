// See LICENSE for license details.

#include "extension.h"
#include <string>
#include <map>

static std::map<std::string, std::function<extension_t*()>>& extensions()
{
  static std::map<std::string, std::function<extension_t*()>> v;
  return v;
}

void register_extension(const char* name, std::function<extension_t*()> f)
{
  extensions()[name] = f;
}

std::function<extension_t*()> find_extension(const char* name)
{
  if (!extensions().count(name)) {
    std::string libname = std::string("lib") + name + ".so";
    fprintf(stderr, "does not support loading extension '%s' (or library '%s')\n",
            name, libname.c_str());
    exit(-1);
  }

  return extensions()[name];
}
