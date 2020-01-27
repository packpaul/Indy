unit IdOpenSSLHeaders_conf_api;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:51

interface

// Headers for OpenSSL 1.1.1
// conf_api.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
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
