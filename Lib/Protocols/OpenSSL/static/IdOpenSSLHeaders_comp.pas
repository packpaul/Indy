unit IdOpenSSLHeaders_comp;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// comp.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ;

  function COMP_CTX_new(meth: PCOMP_METHOD): PCOMP_CTX cdecl; external 'libcrypto-1_1.dll';
  function COMP_CTX_get_method(const ctx: PCOMP_CTX): PCOMP_METHOD cdecl; external 'libcrypto-1_1.dll';
  function COMP_CTX_get_type(const comp: PCOMP_CTX): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function COMP_get_type(const meth: PCOMP_METHOD): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function COMP_get_name(const meth: PCOMP_METHOD): PIdAnsiChar cdecl; external 'libcrypto-1_1.dll';
  procedure COMP_CTX_free(ctx: PCOMP_CTX) cdecl; external 'libcrypto-1_1.dll';

  function COMP_compress_block(ctx: PCOMP_CTX; &out: PByte; olen: TIdC_INT; &in: PByte; ilen: TIdC_INT): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function COMP_expand_block(ctx: PCOMP_CTX; &out: PByte; olen: TIdC_INT; &in: PByte; ilen: TIdC_INT): TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  function COMP_zlib: PCOMP_METHOD cdecl; external 'libcrypto-1_1.dll';

  function BIO_f_zlib: PBIO_METHOD cdecl; external 'libcrypto-1_1.dll';

implementation

end.
