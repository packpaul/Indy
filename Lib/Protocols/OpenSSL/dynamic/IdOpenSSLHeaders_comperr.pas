unit IdOpenSSLHeaders_comperr;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// comperr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
///*
// * COMP function codes.
// */
  COMP_F_BIO_ZLIB_FLUSH =      99;
  COMP_F_BIO_ZLIB_NEW =        100;
  COMP_F_BIO_ZLIB_READ =       101;
  COMP_F_BIO_ZLIB_WRITE =      102;
  COMP_F_COMP_CTX_NEW =        103;

///*
// * COMP reason codes.
// */
  COMP_R_ZLIB_DEFLATE_ERROR =  99;
  COMP_R_ZLIB_INFLATE_ERROR =  100;
  COMP_R_ZLIB_NOT_SUPPORTED =  101;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  ERR_load_COMP_strings: function: TIdC_INT cdecl = nil;

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
    ERR_load_COMP_strings := LoadFunction('ERR_load_COMP_strings', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  ERR_load_COMP_strings := nil;
end;
{$ENDREGION}

end.
