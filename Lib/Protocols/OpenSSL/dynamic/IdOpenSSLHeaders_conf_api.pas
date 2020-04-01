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

unit IdOpenSSLHeaders_conf_api;

interface

// Headers for OpenSSL 1.1.1
// conf_api.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_conf;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  //* Up until OpenSSL 0.9.5a, this was new_section */
  _CONF_new_section: function(conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl = nil;
  //* Up until OpenSSL 0.9.5a, this was get_section */
  _CONF_get_section: function(const conf: PCONF; const section: PAnsiChar): PCONF_VALUE cdecl = nil;
  //* Up until OpenSSL 0.9.5a, this was CONF_get_section */
  //STACK_OF(CONF_VALUE) *_CONF_get_section_values(const CONF *conf,
  //                                               const char *section);

  _CONF_add_string: function(conf: PCONF; section: PCONF_VALUE; value: PCONF_VALUE): TIdC_INT cdecl = nil;
  _CONF_get_string: function(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): PAnsiChar cdecl = nil;
  _CONF_get_number: function(const conf: PCONF; const section: PAnsiChar; const name: PAnsiChar): TIdC_LONG cdecl = nil;

  _CONF_new_data: function(conf: PCONF): TIdC_INT cdecl = nil;
  _CONF_free_data: procedure(conf: PCONF) cdecl = nil;


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
    _CONF_new_section := LoadFunction('_CONF_new_section', LFailed);
    _CONF_get_section := LoadFunction('_CONF_get_section', LFailed);
    _CONF_add_string := LoadFunction('_CONF_add_string', LFailed);
    _CONF_get_string := LoadFunction('_CONF_get_string', LFailed);
    _CONF_get_number := LoadFunction('_CONF_get_number', LFailed);
    _CONF_new_data := LoadFunction('_CONF_new_data', LFailed);
    _CONF_free_data := LoadFunction('_CONF_free_data', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  _CONF_new_section := nil;
  _CONF_get_section := nil;
  _CONF_add_string := nil;
  _CONF_get_string := nil;
  _CONF_get_number := nil;
  _CONF_new_data := nil;
  _CONF_free_data := nil;
end;
{$ENDREGION}

end.
