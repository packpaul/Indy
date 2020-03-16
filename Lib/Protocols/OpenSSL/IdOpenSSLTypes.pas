unit IdOpenSSLTypes;

interface

type
  {$SCOPEDENUMS ON}
  TIdOpenSSLVersion =
  (
    Undefined,
    SSLv3,
    TLSv1,
    TLSv1_1,
    TLSv1_2,
    TLSv1_3
  );

  TGetPassword = procedure(Sender: TObject; var Password: string; const IsWrite: Boolean) of object;
  TKeyLog = procedure (Sender: TObject; const ALine: string) of object;

implementation

end.
