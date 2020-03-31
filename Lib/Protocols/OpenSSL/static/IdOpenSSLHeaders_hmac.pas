{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 31.03.2020 10:11:56

unit IdOpenSSLHeaders_hmac;

interface

// Headers for OpenSSL 1.1.1
// hmac.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdOpenSSLHeaders_ossl_typ;

  function HMAC_size(const e: PHMAC_CTX): TIdC_SIZET cdecl; external 'libcrypto-1_1.dll';
  function HMAC_CTX_new: PHMAC_CTX cdecl; external 'libcrypto-1_1.dll';
  function HMAC_CTX_reset(ctx: PHMAC_CTX): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  procedure HMAC_CTX_free(ctx: PHMAC_CTX) cdecl; external 'libcrypto-1_1.dll';

  function HMAC_Init_ex(ctx: PHMAC_CTX; const key: Pointer; len: TIdC_INT; const md: PEVP_MD; impl: PENGINE): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function HMAC_Update(ctx: PHMAC_CTX; const data: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function HMAC_Final(ctx: PHMAC_CTX; md: PByte; len: PByte): TIdC_INT cdecl; external 'libcrypto-1_1.dll';
  function HMAC(const evp_md: PEVP_MD; const key: Pointer; key_len: TIdC_INT; const d: PByte; n: TIdC_SIZET; md: PByte; md_len: PIdC_INT): PByte cdecl; external 'libcrypto-1_1.dll';
  function HMAC_CTX_copy(dctx: PHMAC_CTX; sctx: PHMAC_CTX): TIdC_INT cdecl; external 'libcrypto-1_1.dll';

  procedure HMAC_CTX_set_flags(ctx: PHMAC_CTX; flags: TIdC_ULONG) cdecl; external 'libcrypto-1_1.dll';
  function HMAC_CTX_get_md(const ctx: PHMAC_CTX): PEVP_MD cdecl; external 'libcrypto-1_1.dll';

implementation

end.