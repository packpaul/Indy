unit IdOpenSSLHeaders_blowfish;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// blowfish.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal;

const
  // Added '_CONST' to avoid name clashes
  BF_ENCRYPT_CONST = 1;
  // Added '_CONST' to avoid name clashes
  BF_DECRYPT_CONST = 0;

  BF_ROUNDS = 16;
  BF_BLOCK  = 8;

type
  BF_LONG = TIdC_UINT;
  PBF_LONG = ^BF_LONG;

  bf_key_st = record
    p: array[0 .. BF_ROUNDS + 2 - 1] of BF_LONG;
    s: array[0 .. 4 * 256 - 1] of BF_LONG;
  end;
  BF_KEY = bf_key_st;
  PBF_KEY = ^BF_KEY;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  BF_set_key: procedure(key: PBF_KEY; len: TIdC_INT; const data: PByte) cdecl = nil;

  BF_encrypt: procedure(data: PBF_LONG; const key: PBF_KEY) cdecl = nil;
  BF_decrypt: procedure(data: PBF_LONG; const key: PBF_KEY) cdecl = nil;

  BF_ecb_encrypt: procedure(const &in: PByte; &out: PByte; key: PBF_KEY; enc: TIdC_INT) cdecl = nil;
  BF_cbc_encrypt: procedure(const &in: PByte; &out: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; enc: TIdC_INT) cdecl = nil;
  BF_cfb64_encrypt: procedure(const &in: PByte; &out: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT; enc: TIdC_INT) cdecl = nil;
  BF_ofb64_encrypt: procedure(const &in: PByte; &out: PByte; length: TIdC_LONG; schedule: PBF_KEY; ivec: PByte; num: PIdC_INT) cdecl = nil;

  BF_options: function: PIdAnsiChar cdecl = nil;

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
    BF_set_key := LoadFunction('BF_set_key', LFailed);
    BF_encrypt := LoadFunction('BF_encrypt', LFailed);
    BF_decrypt := LoadFunction('BF_decrypt', LFailed);
    BF_ecb_encrypt := LoadFunction('BF_ecb_encrypt', LFailed);
    BF_cbc_encrypt := LoadFunction('BF_cbc_encrypt', LFailed);
    BF_cfb64_encrypt := LoadFunction('BF_cfb64_encrypt', LFailed);
    BF_ofb64_encrypt := LoadFunction('BF_ofb64_encrypt', LFailed);
    BF_options := LoadFunction('BF_options', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  BF_set_key := nil;
  BF_encrypt := nil;
  BF_decrypt := nil;
  BF_ecb_encrypt := nil;
  BF_cbc_encrypt := nil;
  BF_cfb64_encrypt := nil;
  BF_ofb64_encrypt := nil;
  BF_options := nil;
end;
{$ENDREGION}

end.
