unit IdOpenSSLHeaders_buffererr;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

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

  function ERR_load_BUF_strings: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

implementation

end.
