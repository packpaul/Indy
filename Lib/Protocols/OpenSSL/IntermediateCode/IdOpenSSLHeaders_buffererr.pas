unit IdOpenSSLHeaders_buffererr;

interface

// Headers for OpenSSL 1.1.1
// buffererr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
// BUF function codes.
  BUF_F_BUF_MEM_GROW = 100;
  BUF_F_BUF_MEM_GROW_CLEAN = 105;
  BUF_F_BUF_MEM_NEW = 101;

// BUF reason codes.

var
  function ERR_load_BUF_strings: TIdC_INT;

implementation

end.
