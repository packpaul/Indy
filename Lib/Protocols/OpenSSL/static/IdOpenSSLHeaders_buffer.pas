unit IdOpenSSLHeaders_buffer;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// buffer.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLHeaders_ossl_typ;

const
  BUF_MEM_FLAG_SECURE = $01;

type
  buf_mem_st = record
    length: size_t;
    data: PIdAnsiChar;
    max: size_t;
    flags: TIdC_ULONG;
  end;

  function BUF_MEM_new: PBUF_MEM cdecl; external 'libcrypto-1_1.dll';
  function BUF_MEM_new_ex(flags: TIdC_ULONG): PBUF_MEM cdecl; external 'libcrypto-1_1.dll';
  procedure BUF_MEM_free(a: PBUF_MEM) cdecl; external 'libcrypto-1_1.dll';
  function BUF_MEM_grow(str: PBUF_MEM; len: size_t): size_t cdecl; external 'libcrypto-1_1.dll';
  function BUF_MEM_grow_clean(str: PBUF_MEM; len: size_t): size_t cdecl; external 'libcrypto-1_1.dll';
  procedure BUF_reverse(&out: PByte; const &in: PByte; siz: size_t) cdecl; external 'libcrypto-1_1.dll';

implementation

end.
