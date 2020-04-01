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

// This File is auto generated!
// Any change to this file should be made in the
// corresponding unit in the folder "intermediate"!

// Generation date: 01.04.2020 14:26:27

unit IdOpenSSLHeaders_idea;

interface

// Headers for OpenSSL 1.1.1
// idea.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  // Added '_CONST' to avoid name clashes
  IDEA_ENCRYPT_CONST = 1;
  // Added '_CONST' to avoid name clashes
  IDEA_DECRYPT_CONST = 0;

  IDEA_BLOCK      = 8;
  IDEA_KEY_LENGTH = 16;

type
  IDEA_INT = type TIdC_INT;

  idea_key_st = record
    data: array[0..8, 0..5] of IDEA_INT;
  end;
  IDEA_KEY_SCHEDULE = idea_key_st;
  PIDEA_KEY_SCHEDULE = ^IDEA_KEY_SCHEDULE;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  IDEA_options: function: PIdAnsiChar cdecl = nil;
  IDEA_ecb_encrypt: procedure(const &in: PByte; &out: PByte; ks: PIDEA_KEY_SCHEDULE) cdecl = nil;
  IDEA_set_encrypt_key: procedure(const key: PByte; ks: PIDEA_KEY_SCHEDULE) cdecl = nil;
  IDEA_set_decrypt_key: procedure(ek: PIDEA_KEY_SCHEDULE; dk: PIDEA_KEY_SCHEDULE) cdecl = nil;
  IDEA_cbc_encrypt: procedure(const &in: PByte; &out: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; enc: TIdC_INT) cdecl = nil;
  IDEA_cfb64_encrypt: procedure(const &in: PByte; &out: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; num: PIdC_INT; enc: TIdC_INT) cdecl = nil;
  IDEA_ofb64_encrypt: procedure(const &in: PByte; &out: PByte; length: TIdC_LONG; ks: PIDEA_KEY_SCHEDULE; iv: PByte; num: PIdC_INT) cdecl = nil;
  IDEA_encrypt: procedure(&in: PIdC_LONG; ks: PIDEA_KEY_SCHEDULE) cdecl = nil;

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
    IDEA_options := LoadFunction('IDEA_options', LFailed);
    IDEA_ecb_encrypt := LoadFunction('IDEA_ecb_encrypt', LFailed);
    IDEA_set_encrypt_key := LoadFunction('IDEA_set_encrypt_key', LFailed);
    IDEA_set_decrypt_key := LoadFunction('IDEA_set_decrypt_key', LFailed);
    IDEA_cbc_encrypt := LoadFunction('IDEA_cbc_encrypt', LFailed);
    IDEA_cfb64_encrypt := LoadFunction('IDEA_cfb64_encrypt', LFailed);
    IDEA_ofb64_encrypt := LoadFunction('IDEA_ofb64_encrypt', LFailed);
    IDEA_encrypt := LoadFunction('IDEA_encrypt', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  IDEA_options := nil;
  IDEA_ecb_encrypt := nil;
  IDEA_set_encrypt_key := nil;
  IDEA_set_decrypt_key := nil;
  IDEA_cbc_encrypt := nil;
  IDEA_cfb64_encrypt := nil;
  IDEA_ofb64_encrypt := nil;
  IDEA_encrypt := nil;
end;
{$ENDREGION}

end.
