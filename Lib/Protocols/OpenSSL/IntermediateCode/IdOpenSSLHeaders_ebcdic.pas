unit IdOpenSSLHeaders_ebcdic;

interface

// Headers for OpenSSL 1.1.1
// ebcdic.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;

var

  //extern const unsigned char os_toascii[256];
  //extern const unsigned char os_toebcdic[256];

  function ebcdic2ascii(dest: Pointer; const srce: Pointer; count: size_t): Pointer;
  function ascii2ebcdic(dest: Pointer; const srce: Pointer; count: size_t): Pointer;

implementation

end.
