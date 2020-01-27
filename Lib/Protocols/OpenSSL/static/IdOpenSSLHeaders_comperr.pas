unit IdOpenSSLHeaders_comperr;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// comperr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
///*
// * COMP function codes.
// */
  COMP_F_BIO_ZLIB_FLUSH =      99;
  COMP_F_BIO_ZLIB_NEW =        100;
  COMP_F_BIO_ZLIB_READ =       101;
  COMP_F_BIO_ZLIB_WRITE =      102;
  COMP_F_COMP_CTX_NEW =        103;

///*
// * COMP reason codes.
// */
  COMP_R_ZLIB_DEFLATE_ERROR =  99;
  COMP_R_ZLIB_INFLATE_ERROR =  100;
  COMP_R_ZLIB_NOT_SUPPORTED =  101;

  function ERR_load_COMP_strings: TIdC_INT cdecl; external 'libcrypto-1_1.dll';

implementation

end.
