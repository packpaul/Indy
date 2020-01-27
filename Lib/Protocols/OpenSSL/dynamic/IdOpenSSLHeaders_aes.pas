unit IdOpenSSLHeaders_aes;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// aes.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal;

const
// Added '_CONST' to avoid name clashes
  AES_ENCRYPT_CONST = 1;
// Added '_CONST' to avoid name clashes
  AES_DECRYPT_CONST = 0;
  AES_MAXNR = 14;
  AES_BLOCK_SIZE = 16;

type
  aes_key_st = record
  // in old IdSSLOpenSSLHeaders.pas it was also TIdC_UINT ¯\_(ツ)_/¯
//    {$IFDEF AES_LONG}
//    rd_key: array[0..(4 * (AES_MAXNR + 1))] of TIdC_ULONG;
//    {$ELSE}
    rd_key: array[0..(4 * (AES_MAXNR + 1))] of TIdC_UINT;
//    {$ENDIF}
    rounds: TIdC_INT;
  end;
  AES_KEY = aes_key_st;
  PAES_KEY = ^AES_KEY;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  AES_options: function: PIdAnsiChar cdecl = nil;

  AES_set_encrypt_key: function(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl = nil;
  AES_set_decrypt_key: function(const userKey: PByte; const bits: TIdC_INT; const key: PAES_KEY): TIdC_INT cdecl = nil;

  AES_encrypt: procedure(const &in: PByte; &out: PByte; const key: PAES_KEY) cdecl = nil;
  AES_decrypt: procedure(const &in: PByte; &out: PByte; const key: PAES_KEY) cdecl = nil;

  AES_ecb_encrypt: procedure(const &in: PByte; &out: PByte; const key: PAES_KEY; const enc: TIdC_INT) cdecl = nil;
  AES_cbc_encrypt: procedure(const &in: PByte; &out: PByte; length: size_t; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl = nil;
  AES_cfb128_encrypt: procedure(const &in: PByte; &out: PByte; length: size_T; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  AES_cfb1_encrypt: procedure(const &in: PByte; &out: PByte; length: size_T; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  AES_cfb8_encrypt: procedure(const &in: PByte; &out: PByte; length: size_T; const key: PAES_KEY; ivec: PByte; num: PIdC_INT; const enc: TIdC_INT) cdecl = nil;
  AES_ofb128_encrypt: procedure(const &in: PByte; &out: PByte; length: size_T; const key: PAES_KEY; ivec: PByte; num: PIdC_INT) cdecl = nil;
  (* NB: the IV is _two_ blocks long *)
  AES_ige_encrypt: procedure(const &in: PByte; &out: PByte; length: size_T; const key: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl = nil;
  (* NB: the IV is _four_ blocks long *)
  AES_bi_ige_encrypt: procedure(const &in: PByte; &out: PByte; length: size_T; const key: PAES_KEY; const key2: PAES_KEY; ivec: PByte; const enc: TIdC_INT) cdecl = nil;

  AES_wrap_key: function(key: PAES_KEY; const iv: PByte; &out: PByte; const &in: PByte; inlen: TIdC_UINT): TIdC_INT cdecl = nil;
  AES_unwrap_key: function(key: PAES_KEY; const iv: PByte; &out: PByte; const &in: PByte; inlen: TIdC_UINT): TIdC_INT cdecl = nil;

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
    AES_options := LoadFunction('AES_options', LFailed);
    AES_set_encrypt_key := LoadFunction('AES_set_encrypt_key', LFailed);
    AES_set_decrypt_key := LoadFunction('AES_set_decrypt_key', LFailed);
    AES_encrypt := LoadFunction('AES_encrypt', LFailed);
    AES_decrypt := LoadFunction('AES_decrypt', LFailed);
    AES_ecb_encrypt := LoadFunction('AES_ecb_encrypt', LFailed);
    AES_cbc_encrypt := LoadFunction('AES_cbc_encrypt', LFailed);
    AES_cfb128_encrypt := LoadFunction('AES_cfb128_encrypt', LFailed);
    AES_cfb1_encrypt := LoadFunction('AES_cfb1_encrypt', LFailed);
    AES_cfb8_encrypt := LoadFunction('AES_cfb8_encrypt', LFailed);
    AES_ofb128_encrypt := LoadFunction('AES_ofb128_encrypt', LFailed);
    AES_ige_encrypt := LoadFunction('AES_ige_encrypt', LFailed);
    AES_bi_ige_encrypt := LoadFunction('AES_bi_ige_encrypt', LFailed);
    AES_wrap_key := LoadFunction('AES_wrap_key', LFailed);
    AES_unwrap_key := LoadFunction('AES_unwrap_key', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  AES_options := nil;
  AES_set_encrypt_key := nil;
  AES_set_decrypt_key := nil;
  AES_encrypt := nil;
  AES_decrypt := nil;
  AES_ecb_encrypt := nil;
  AES_cbc_encrypt := nil;
  AES_cfb128_encrypt := nil;
  AES_cfb1_encrypt := nil;
  AES_cfb8_encrypt := nil;
  AES_ofb128_encrypt := nil;
  AES_ige_encrypt := nil;
  AES_bi_ige_encrypt := nil;
  AES_wrap_key := nil;
  AES_unwrap_key := nil;
end;
{$ENDREGION}

end.
