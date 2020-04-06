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

unit IdOpenSSLUtils;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal;

function GetPAnsiChar(const s: UTF8String): PIdAnsiChar;
function GetPAnsiCharOrNil(const s: UTF8String): PIdAnsiChar;
function GetString(const p: PIdAnsiChar): string;

implementation

uses
//{$IFDEF USE_MARSHALLED_PTRS}
//{$IFDEF MSWINDOWS} // prevent "[dcc32 Hint] H2443 Inline function 'TMarshaller.AsUtf8'
//  Windows,         // has not been expanded because unit 'Winapi.Windows' is not
//{$ENDIF MSWINDOWS} // specified in USES list" ¯\_(ツ)_/¯
//{$ENDIF}
  SysUtils;

function GetPAnsiChar(const s: UTF8String): PIdAnsiChar;
//{$IFDEF USE_MARSHALLED_PTRS}
//var
//  m: TMarshaller;
//{$ENDIF}
begin
//  {$IFDEF USE_MARSHALLED_PTRS}
//  Result := m.AsUtf8(string(s)).ToPointer;
//  {$ELSE}
  Result := PIdAnsiChar(Pointer(s));
//  {$ENDIF}
end;

function GetPAnsiCharOrNil(const s: UTF8String): PIdAnsiChar;
begin
  if s = '' then
    Result := nil
  else
    Result := GetPAnsiChar(s);
end;

function GetString(const p: PIdAnsiChar): string;
begin
  Result := string(AnsiString(p));
end;

end.
