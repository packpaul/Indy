unit IdOpenSSLHeaders_ebcdic;

// This File is generated!
// Any modification should be in the respone unit in the 
// responding unit in the "intermediate" folder! 

// Generation date: 27.01.2020 13:25:53

interface

// Headers for OpenSSL 1.1.1
// ebcdic.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes;


  //extern const unsigned char os_toascii[256];
  //extern const unsigned char os_toebcdic[256];

  function ebcdic2ascii(dest: Pointer; const srce: Pointer; count: size_t): Pointer cdecl; external 'libcrypto-1_1.dll';
  function ascii2ebcdic(dest: Pointer; const srce: Pointer; count: size_t): Pointer cdecl; external 'libcrypto-1_1.dll';

implementation

end.
