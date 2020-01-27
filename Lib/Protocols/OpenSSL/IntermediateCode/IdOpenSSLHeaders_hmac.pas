unit IdOpenSSLHeaders_hmac;

interface

// Headers for OpenSSL 1.1.1
// hmac.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdOpenSSLHeaders_ossl_typ;

var
  function HMAC_size(const e: PHMAC_CTX): size_t;
  function HMAC_CTX_new: PHMAC_CTX;
  function HMAC_CTX_reset(ctx: PHMAC_CTX): TIdC_INT;
  procedure HMAC_CTX_free(ctx: PHMAC_CTX);

  function HMAC_Init_ex(ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT;
  function HMAC_Update(ctx: PHMAC_CTX; const data: PByte; len: size_t): TIdC_INT;
  function HMAC_Final(ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT;
  function HMAC(const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: size_t; md: PByte; md_len: PIdC_INT): PByte;
  function HMAC_CTX_copy(dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT;

  procedure HMAC_CTX_set_flags(ctx: PHMAC_CTX; flags: TIdC_ULONG);
  function HMAC_CTX_get_md(const ctx: PHMAC_CTX): PEVP_MD;

implementation

end.
