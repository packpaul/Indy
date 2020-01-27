unit IdOpenSSLHeaders_ebcdic;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// ebcdic.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var

  //extern const unsigned char os_toascii[256];
  //extern const unsigned char os_toebcdic[256];

  ebcdic2ascii: function(dest: Pointer; const srce: Pointer; count: size_t): Pointer cdecl = nil;
  ascii2ebcdic: function(dest: Pointer; const srce: Pointer; count: size_t): Pointer cdecl = nil;

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
    ebcdic2ascii := LoadFunction('ebcdic2ascii', LFailed);
    ascii2ebcdic := LoadFunction('ascii2ebcdic', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  ebcdic2ascii := nil;
  ascii2ebcdic := nil;
end;
{$ENDREGION}

end.
