unit IdOpenSSLHeaders_cmac;

interface

// Headers for OpenSSL 1.1.1
// cmac.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLHeaders_evp,
  IdOpenSSLHeaders_ossl_typ;

//* Opaque */
type
  CMAC_CTX_st = type Pointer;
  CMAC_CTX = CMAC_CTX_st;
  PCMAC_CTX = ^CMAC_CTX;

var
  function CMAC_CTX_new: PCMAC_CTX;
  procedure CMAC_CTX_cleanup(ctx: PCMAC_CTX);
  procedure CMAC_CTX_free(ctx: PCMAC_CTX);
  function CMAC_CTX_get0_cipher_ctx(ctx: PCMAC_CTX): PEVP_CIPHER_CTX;
  function CMAC_CTX_copy(out: PCMAC_CTX; const &in: PCMAC_CTX): TIdC_INT;
  function CMAC_Init(ctx: PCMAC_CTX; const key: Pointer; keylen: Size_t; const cipher: PEVP_Cipher; impl: PENGINe): TIdC_INT;
  function CMAC_Update(ctx: PCMAC_CTX; const data: Pointer; dlen: Size_t): TIdC_INT;
  function CMAC_Final(ctx: PCMAC_CTX; &out: PByte; poutlen: PSize_t): TIdC_INT;
  function CMAC_resume(ctx: PCMAC_CTX): TIdC_INT;

implementation

end.
