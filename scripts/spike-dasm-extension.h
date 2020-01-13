// See LICENSE for license details.

#ifndef _RISCV_COPROCESSOR_H
#define _RISCV_COPROCESSOR_H

#include "disasm.h"
#include <vector>
#include <functional>

class extension_t
{
 public:
  virtual std::vector<disasm_insn_t*> get_disasms() = 0;
};

std::function<extension_t*()> find_extension(const char* name);

#endif
