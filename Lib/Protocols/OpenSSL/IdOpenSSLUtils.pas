unit IdOpenSSLUtils;

interface

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
