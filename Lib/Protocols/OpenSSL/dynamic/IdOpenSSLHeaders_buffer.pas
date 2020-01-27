unit IdOpenSSLHeaders_buffer;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// buffer.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLHeaders_ossl_typ;

const
  BUF_MEM_FLAG_SECURE = $01;

type
  buf_mem_st = record
    length: size_t;
    data: PIdAnsiChar;
    max: size_t;
    flags: TIdC_ULONG;
  end;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  BUF_MEM_new: function: PBUF_MEM cdecl = nil;
  BUF_MEM_new_ex: function(flags: TIdC_ULONG): PBUF_MEM cdecl = nil;
  BUF_MEM_free: procedure(a: PBUF_MEM) cdecl = nil;
  BUF_MEM_grow: function(str: PBUF_MEM; len: size_t): size_t cdecl = nil;
  BUF_MEM_grow_clean: function(str: PBUF_MEM; len: size_t): size_t cdecl = nil;
  BUF_reverse: procedure(&out: PByte; const &in: PByte; siz: size_t) cdecl = nil;

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
    BUF_MEM_new := LoadFunction('BUF_MEM_new', LFailed);
    BUF_MEM_new_ex := LoadFunction('BUF_MEM_new_ex', LFailed);
    BUF_MEM_free := LoadFunction('BUF_MEM_free', LFailed);
    BUF_MEM_grow := LoadFunction('BUF_MEM_grow', LFailed);
    BUF_MEM_grow_clean := LoadFunction('BUF_MEM_grow_clean', LFailed);
    BUF_reverse := LoadFunction('BUF_reverse', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  BUF_MEM_new := nil;
  BUF_MEM_new_ex := nil;
  BUF_MEM_free := nil;
  BUF_MEM_grow := nil;
  BUF_MEM_grow_clean := nil;
  BUF_reverse := nil;
end;
{$ENDREGION}

end.
