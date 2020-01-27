unit IdOpenSSLHeaders_objectserr;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// objectserr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

const
  (*
   * OBJ function codes.
   *)
  OBJ_F_OBJ_ADD_OBJECT =  105;
  OBJ_F_OBJ_ADD_SIGID =  107;
  OBJ_F_OBJ_CREATE =   100;
  OBJ_F_OBJ_DUP =   101;
  OBJ_F_OBJ_NAME_NEW_INDEX =  106;
  OBJ_F_OBJ_NID2LN =   102;
  OBJ_F_OBJ_NID2OBJ =   103;
  OBJ_F_OBJ_NID2SN =   104;
  OBJ_F_OBJ_TXT2OBJ =   108;

  (*
   * OBJ reason codes.
   *)
  OBJ_R_OID_EXISTS = 102;
  OBJ_R_UNKNOWN_NID = 101;

{$REGION 'Generated loading and unloading methods'}
function Load(const ADllHandle: THandle): TArray<string>;
procedure UnLoad;
{$ENDREGION}

var
  ERR_load_OBJ_strings: function: TIdC_INT cdecl = nil;

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
    ERR_load_OBJ_strings := LoadFunction('ERR_load_OBJ_strings', LFailed);
    Result := LFailed.ToStringArray();
  finally
    LFailed.Free();
  end;
end;

procedure UnLoad;
begin
  ERR_load_OBJ_strings := nil;
end;
{$ENDREGION}

end.
