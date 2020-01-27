unit IdOpenSSLHeaders_buffer;

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

var
  function BUF_MEM_new: PBUF_MEM;
  function BUF_MEM_new_ex(flags: TIdC_ULONG): PBUF_MEM;
  procedure BUF_MEM_free(a: PBUF_MEM);
  function BUF_MEM_grow(str: PBUF_MEM; len: size_t): size_t;
  function BUF_MEM_grow_clean(str: PBUF_MEM; len: size_t): size_t;
  procedure BUF_reverse(&out: PByte; const &in: PByte; siz: size_t);

implementation

end.
