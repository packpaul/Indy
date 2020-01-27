unit IdOpenSSLHeaders_objectserr;

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

var
  function ERR_load_OBJ_strings: TIdC_INT;

implementation

end.
