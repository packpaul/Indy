unit IdOpenSSLHeaders_whrlpool;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// whrlpool.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
  WHIRLPOOL_DIGEST_LENGTH = 512 div 8;
  WHIRLPOOL_BBLOCK = 512;
  WHIRLPOOL_COUNTER = 256 div 8;

type
  WHIRLPOOL_CTX_union = record
    case Byte of
      0: (c: array[0 .. WHIRLPOOL_DIGEST_LENGTH -1] of Byte);
      (* double q is here to ensure 64-bit alignment *)
      1: (q: array[0 .. (WHIRLPOOL_DIGEST_LENGTH div SizeOf(TIdC_DOUBLE)) -1] of TIdC_DOUBLE);
  end;
  WHIRLPOOL_CTX = record
    H: WHIRLPOOL_CTX_union;
    data: array[0 .. (WHIRLPOOL_BBLOCK div 8) -1] of Byte;
    bitoff: TIdC_UINT;
    bitlen: array[0 .. (WHIRLPOOL_COUNTER div SizeOf(size_t)) -1] of size_t;
  end;
  PWHIRLPOOL_CTX = ^WHIRLPOOL_CTX;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  WHIRLPOOL_Init: function(c: PWHIRLPOOL_CTX): TIdC_INT cdecl = nil;
  WHIRLPOOL_Update: function(c: PWHIRLPOOL_CTX; inp: Pointer; bytes: Size_t): TIdC_INT cdecl = nil;
  WHIRLPOOL_BitUpdate: procedure(c: PWHIRLPOOL_CTX; inp: Pointer; bits: Size_t) cdecl = nil;
  WHIRLPOOL_Final: function(md: PByte; c: PWHIRLPOOL_CTX): TIdC_INT cdecl = nil;
  WHIRLPOOL: function(inp: Pointer; bytes: Size_t; md: PByte): PByte cdecl = nil;

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
    WHIRLPOOL_Init := LoadFunction('WHIRLPOOL_Init', LFailed);
    WHIRLPOOL_Update := LoadFunction('WHIRLPOOL_Update', LFailed);
    WHIRLPOOL_BitUpdate := LoadFunction('WHIRLPOOL_BitUpdate', LFailed);
    WHIRLPOOL_Final := LoadFunction('WHIRLPOOL_Final', LFailed);
    WHIRLPOOL := LoadFunction('WHIRLPOOL', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  WHIRLPOOL_Init := nil;
  WHIRLPOOL_Update := nil;
  WHIRLPOOL_BitUpdate := nil;
  WHIRLPOOL_Final := nil;
  WHIRLPOOL := nil;
end;
{$ENDREGION}

end.
