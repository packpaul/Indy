unit IdOpenSSLHeaders_cmac;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

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

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  CMAC_CTX_new: function: PCMAC_CTX cdecl = nil;
  CMAC_CTX_cleanup: procedure(ctx: PCMAC_CTX) cdecl = nil;
  CMAC_CTX_free: procedure(ctx: PCMAC_CTX) cdecl = nil;
  CMAC_CTX_get0_cipher_ctx: function(ctx: PCMAC_CTX): PEVP_CIPHER_CTX cdecl = nil;
  CMAC_CTX_copy: function(out: PCMAC_CTX; const &in: PCMAC_CTX): TIdC_INT cdecl = nil;
  CMAC_Init: function(ctx: PCMAC_CTX; const key: Pointer; keylen: Size_t; const cipher: PEVP_Cipher; impl: PENGINe): TIdC_INT cdecl = nil;
  CMAC_Update: function(ctx: PCMAC_CTX; const data: Pointer; dlen: Size_t): TIdC_INT cdecl = nil;
  CMAC_Final: function(ctx: PCMAC_CTX; &out: PByte; poutlen: PSize_t): TIdC_INT cdecl = nil;
  CMAC_resume: function(ctx: PCMAC_CTX): TIdC_INT cdecl = nil;


implementation

uses
  System.Classes,
  Winapi.Windows;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := GetProcAddress(ADllHandle, PChar(AMethodName));
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

var
  LFailed: TStringList;
begin
  LFailed := TStringList.Create();
  try
    CMAC_CTX_new := LoadFunction('CMAC_CTX_new', LFailed);
    CMAC_CTX_cleanup := LoadFunction('CMAC_CTX_cleanup', LFailed);
    CMAC_CTX_free := LoadFunction('CMAC_CTX_free', LFailed);
    CMAC_CTX_get0_cipher_ctx := LoadFunction('CMAC_CTX_get0_cipher_ctx', LFailed);
    CMAC_CTX_copy := LoadFunction('CMAC_CTX_copy', LFailed);
    CMAC_Init := LoadFunction('CMAC_Init', LFailed);
    CMAC_Update := LoadFunction('CMAC_Update', LFailed);
    CMAC_Final := LoadFunction('CMAC_Final', LFailed);
    CMAC_resume := LoadFunction('CMAC_resume', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  CMAC_CTX_new := nil;
  CMAC_CTX_cleanup := nil;
  CMAC_CTX_free := nil;
  CMAC_CTX_get0_cipher_ctx := nil;
  CMAC_CTX_copy := nil;
  CMAC_Init := nil;
  CMAC_Update := nil;
  CMAC_Final := nil;
  CMAC_resume := nil;
end;
{$ENDREGION}

end.
