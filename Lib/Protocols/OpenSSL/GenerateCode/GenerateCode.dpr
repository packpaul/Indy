program GenerateCode;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.Classes,
  System.IOUtils,
  System.Types,
  System.SysUtils,
  Winapi.Windows,
  System.StrUtils;

type
  TGenerateMode = (gmDynamic, gmStatic);

function ExpandEnvironmentVariables(const AValue: string): string;
const
  MAX_LENGTH = 32767;
begin
  SetLength(Result, MAX_LENGTH);
  SetLength(Result, ExpandEnvironmentStrings(@AValue[1], @Result[1], MAX_LENGTH)-1);
end;

function ReplaceStatic(const ALine: string; const AShouldUseLibSSL: Boolean): string;
const
  CSemicolon: string = ';';
var
  i: Integer;
begin
  Result := ALine;
  i := Result.LastIndexOf(CSemicolon);
  if i = -1 then
    Exit;
  Result := Result.Remove(i, CSemicolon.Length);
  Result := Result.Insert(i, Format(' cdecl; external ''%s'';', [IfThen(AShouldUseLibSSL, 'libssl-1_1.dll', 'libcrypto-1_1.dll')]));
  {TODO -oFabian S. Biehn -cStatic Linking : LibCrypto FileName}
end;

function ReplaceDynamic(const ALine: string; const AMethodList: TStringList): string;
var
  i: Integer;
  LMethodPrefix: string;
  LMethod: string;
begin
  Result := ALine;

  if not Result.TrimLeft.StartsWith('function') and not Result.TrimLeft.StartsWith('procedure') then
    Exit;

  LMethodPrefix := 'function';
  i := Result.IndexOf(LMethodPrefix);
  if i = -1 then
  begin
    LMethodPrefix := 'procedure';
    i := Result.IndexOf(LMethodPrefix);
    if i = -1 then
      Exit;
  end;

  // Remove LMethodPrefix
  Result := Result.Remove(i, LMethodPrefix.Length + string(' ').Length);
  // Keep Result for method name extracting later
  LMethod := Result.TrimLeft();
  // Add LMethodPrefix after parameters
  if Result.Contains(')') then
    Result := Result.Replace('(', ': ' + LMethodPrefix + '(')
  // No Params? Add LMethodPrefix after before return type
  else if Result.Contains(': ') then
    Result := Result.Replace(': ', ': ' + LMethodPrefix + ': ')
  // Also no return type? Add LMethodPrefix before semi colon
  else
    Result := Result.Replace(';', ': ' + LMethodPrefix + ';');

  if Result[Result.Length] = ';' then
    Result := Result.Remove(Result.Length-1) + ' cdecl = nil;';

  // Ignore comments
  i := LMethod.IndexOf('}');
  if i > -1 then
    // +1 for including } and Trim for removing whitespace of intendation
    LMethod := LMethod.Substring(i + 1{, LMethod.Length - i}).TrimLeft;
  i := LMethod.IndexOf(';');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  i := LMethod.IndexOf(' ');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  i := LMethod.IndexOf(':');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  i := LMethod.IndexOf('(');
  if i > -1 then
    LMethod := LMethod.Remove(i);
  AMethodList.Add(LMethod);
end;

procedure AddDynamicLoadingMethods(
  const AFile: TStringList;
  const AMethods: TStringList;
  const AVarIndex: Integer;
  const AImplementationIndex: Integer);

  procedure Insert(AList: TStringList; const str: string; var Index: Integer);
  begin
    AList.Insert(Index, str);
    Inc(Index);
  end;

//  function Load(const AMethodName: string): Pointer;
//  begin
//    Result := GetProcAddress(0, PChar(AMethodName));
//    if not Assigned(Result) then
//      LFailed.Add(AMethodName);
//  end;

var
  LOffset: Integer;
  LMethod: string;
begin
  if AImplementationIndex = -1 then
    Exit;
  LOffset := AImplementationIndex + 1;

  {TODO -oFabian S. Biehn -cDynamic Linking : Improve loading mechanism for different platforms & lower versions}
  Insert(AFile, '', LOffset);
  Insert(AFile, 'uses', LOffset);
  if not AFile.Text.Contains('Types') then
    Insert(AFile, '  System.Types,', LOffset);
  if not AFile.Text.Contains('Classes') then
  Insert(AFile, '  System.Classes,', LOffset);
  Insert(AFile, '  Winapi.Windows;', LOffset);
  Insert(AFile, '', LOffset);
  Insert(AFile, '{$REGION ''Generated loading and unloading methods''}', LOffSet);
  Insert(AFile, 'function Load(const ADllHandle: THandle): TArray<string>;', LOffset);
  Insert(AFile, '', LOffset);
  Insert(AFile, '  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;', LOffset);
  Insert(AFile, '  begin', LOffset);
  Insert(AFile, '    Result := GetProcAddress(ADllHandle, PChar(AMethodName));', LOffset);
  Insert(AFile, '    if not Assigned(Result) then', LOffset);
  Insert(AFile, '      AFailed.Add(AMethodName);', LOffset);
  Insert(AFile, '  end;', LOffset);
  Insert(AFile, '', LOffset);
  Insert(AFile, 'var', LOffset);
  Insert(AFile, '  LFailed: TStringList;', LOffset);
  Insert(AFile, 'begin', LOffset);
  Insert(AFile, '  LFailed := TStringList.Create();', LOffset);
  Insert(AFile, '  try', LOffset);
  for LMethod in AMethods do
    Insert(AFile, Format('    %0:s := LoadFunction(''%0:s'', LFailed);', [LMethod]), LOffset);
  Insert(AFile, '    Result := LFailed.ToStringArray();', LOffset);
  Insert(AFile, '  finally', LOffset);
  Insert(AFile, '    LFailed.Free();', LOffset);
  Insert(AFile, '  end;', LOffset);
  Insert(AFile, 'end;', LOffset);
  Insert(AFile, '', LOffset);


  Insert(AFile, 'procedure UnLoad;', LOffset);
  Insert(AFile, 'begin', LOffset);
  for LMethod in AMethods do
    Insert(AFile, Format('  %s := nil;', [LMethod]), LOffset);
  Insert(AFile, 'end;', LOffset);
  Insert(AFile, '{$ENDREGION}', LOffSet);

  if AVarIndex = -1 then
    Exit;
  LOffSet := Pred(AVarIndex);
  Insert(AFile, '', LOffSet);
  Insert(AFile, '{$REGION ''Generated loading and unloading methods''}', LOffSet);
  Insert(AFile, 'function Load(const ADllHandle: THandle): TArray<string>;', LOffSet);
  Insert(AFile, 'procedure UnLoad;', LOffSet);
  Insert(AFile, '{$ENDREGION}', LOffSet);
//  AFile.Insert(Pred(AVarIndex), 'function Load(const ADllHandle: THandle): TArray<string>;');
end;

function ShouldSkipLine(ALine: string): Boolean;
begin
  ALine := ALine.Trim;
  Result := ALine.IsEmpty;
  Result := Result or ALine.StartsWith('//');
  Result := Result or ALine.StartsWith('(*');
  Result := Result or ALine.StartsWith('*');
end;

function ReadParameters(out ASource: string; out ATarget: string; out AMode: TGenerateMode): Boolean;
var
  LMode: string;
begin
  Result := True;
  if not FindCmdLineSwitch('Source', ASource) then
  begin
    Writeln('No source folder!');
    Exit(False);
  end;
  ASource := ExpandEnvironmentVariables(ASource);

  if not FindCmdLineSwitch('Target', ATarget) then
  begin
    Writeln('No target folder!');
    Exit(False);
  end;
  ATarget := ExpandEnvironmentVariables(ATarget);

  if not FindCmdLineSwitch('Mode', LMode) then
  begin
    Writeln('No mode!');
    Exit(False);
  end;

  if LMode = 'dynamic' then
    AMode := gmDynamic
  else if LMode = 'static' then
    AMode := gmStatic
  else
  begin
    Writeln('Invalid mode! Use "dynamic" or "static"!');
    Exit(False);
  end;
end;

procedure AddGeneratedHeader(const AFile: TStringList);
const
  CHeader: array[0..4] of string =
  (
   '',
   '// This File is generated!',
   '// Any modification should be in the respone unit in the ',
   '// responding unit in the "intermediate" folder! ',
   ''
  );
var
  i: Integer;
  LOffset: Integer;
begin
  LOffset := 1;
  for i := Low(CHeader) to High(CHeader) do
    AFile.Insert(i + LOffset, CHeader[i]);
  AFile.Insert(Length(CHeader) + LOffset, '// Generation date: ' + DateTimeToStr(Now()));
end;

procedure Main;
var
  LFile: string;
  LStringListFile: TStringList;
  i: Integer;
  LVarIndex: Integer;
  LSource: string;
  LTarget: string;
  LMode: TGenerateMode;
  LStringListMethods: TStringList;
  LImplementationIndex: Integer;
  LFileName: string;
  LShouldUseLibSSL: Boolean;
begin
  if not ReadParameters(LSource, LTarget, LMode) then
  begin
    Readln;
    Exit;
  end;

  for LFile in TDirectory.GetFiles(LSource, '*.pas') do
  begin
    LShouldUseLibSSL := False;
    Writeln('Converting ' + LFile);
    LFileName := TPath.GetFileName(LFile);
    LStringListFile := TStringList.Create();
    LStringListMethods := TStringList.Create();
    try
      LStringListFile.LoadFromFile(LFile);
      LVarIndex := -1;
      LImplementationIndex := -1;
      for i := 0 to LStringListFile.Count - 1 do
      begin
        if LStringListFile[i].StartsWith('unit ') then
          LShouldUseLibSSL := MatchText(LStringListFile[i], ['unit IdOpenSSLHeaders_ssl;', 'unit IdOpenSSLHeaders_sslerr;', 'unit IdOpenSSLHeaders_tls1;']);
        // var block found?
        if (LVarIndex = -1) and LStringListFile[i].StartsWith('var') then
          LVarIndex := i;
        // Skip until we find the var block
        if (LVarIndex = -1) or ShouldSkipLine(LStringListFile[i]) then
          Continue;

        // No need to go further than "implementation"
        if LStringListFile[i] = 'implementation' then
        begin
          LImplementationIndex := i;
          Break;
        end;

        case LMode of
          gmDynamic:
            LStringListFile[i] := ReplaceDynamic(LStringListFile[i], LStringListMethods);
          gmStatic:
            LStringListFile[i] := ReplaceStatic(LStringListFile[i], LShouldUseLibSSL);
        end;
      end;

      case LMode of
        gmDynamic:
          AddDynamicLoadingMethods(LStringListFile, LStringListMethods, LVarIndex, LImplementationIndex);
        gmStatic:
          if LVarIndex > -1 then
            LStringListFile.Delete(LVarIndex);
      end;

      AddGeneratedHeader(LStringListFile);

      LStringListFile.SaveToFile(TPath.Combine(LTarget, LFileName));
    finally
      LStringListMethods.Free();
      LStringListFile.Free();
    end;
  end;
end;

begin
  try
    Main;
    Writeln('done');
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
    end;
  end;
//  Readln;
end.
