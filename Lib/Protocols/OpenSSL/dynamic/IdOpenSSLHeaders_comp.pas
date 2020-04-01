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

unit IdOpenSSLHeaders_comp;

interface

// Headers for OpenSSL 1.1.1
// comp.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_ossl_typ;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  COMP_CTX_new: function(meth: PCOMP_METHOD): PCOMP_CTX cdecl = nil;
  COMP_CTX_get_method: function(const ctx: PCOMP_CTX): PCOMP_METHOD cdecl = nil;
  COMP_CTX_get_type: function(const comp: PCOMP_CTX): TIdC_INT cdecl = nil;
  COMP_get_type: function(const meth: PCOMP_METHOD): TIdC_INT cdecl = nil;
  COMP_get_name: function(const meth: PCOMP_METHOD): PIdAnsiChar cdecl = nil;
  COMP_CTX_free: procedure(ctx: PCOMP_CTX) cdecl = nil;

  COMP_compress_block: function(ctx: PCOMP_CTX; &out: PByte; olen: TIdC_INT; &in: PByte; ilen: TIdC_INT): TIdC_INT cdecl = nil;
  COMP_expand_block: function(ctx: PCOMP_CTX; &out: PByte; olen: TIdC_INT; &in: PByte; ilen: TIdC_INT): TIdC_INT cdecl = nil;

  COMP_zlib: function: PCOMP_METHOD cdecl = nil;

  BIO_f_zlib: function: PBIO_METHOD cdecl = nil;

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
    COMP_CTX_new := LoadFunction('COMP_CTX_new', LFailed);
    COMP_CTX_get_method := LoadFunction('COMP_CTX_get_method', LFailed);
    COMP_CTX_get_type := LoadFunction('COMP_CTX_get_type', LFailed);
    COMP_get_type := LoadFunction('COMP_get_type', LFailed);
    COMP_get_name := LoadFunction('COMP_get_name', LFailed);
    COMP_CTX_free := LoadFunction('COMP_CTX_free', LFailed);
    COMP_compress_block := LoadFunction('COMP_compress_block', LFailed);
    COMP_expand_block := LoadFunction('COMP_expand_block', LFailed);
    COMP_zlib := LoadFunction('COMP_zlib', LFailed);
    BIO_f_zlib := LoadFunction('BIO_f_zlib', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  COMP_CTX_new := nil;
  COMP_CTX_get_method := nil;
  COMP_CTX_get_type := nil;
  COMP_get_type := nil;
  COMP_get_name := nil;
  COMP_CTX_free := nil;
  COMP_compress_block := nil;
  COMP_expand_block := nil;
  COMP_zlib := nil;
  BIO_f_zlib := nil;
end;
{$ENDREGION}

end.
