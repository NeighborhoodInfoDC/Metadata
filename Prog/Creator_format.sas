/**************************************************************************
 Program:  Creator_format.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/13/13
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description: Create $creator format for formatting file creator
 names in metadata.

 Notes:
 - NEVER REMOVE PAST USERNAMES from list of values.
 - Unformatted usernames (left of = sign) should be in all lowercase.
 - Use the full (long) username (ex: "awilliams", not "awilliam"). 
     (Older users had both long and short usernames, but it is 
     no longer necessary to include short usernames here.)
 - Update the General\Prog\Format_longusr.sas program for 
   usernames longer than 8 characters.
 
 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

proc format library=Metadata;
  value $creator
    "ptatian"  = "P Tatian"
    "awilliam" = "A Williams"
    "awilliams" = "A Williams"
    "chedman" = "C Hedman"
    "lgetsing" = "L Getsinger"
    "lgetsinger" = "L Getsinger"
    "eguernse" = "E Guernsey"
    "lhendey"  = "L Hendey"
    "rrosso"   = "R Rosso"
    "jfenders" = "J Fenderson"
    "jdev" = "J Dev"
    "bchang"   = "B Chang"
    "dprice"   = "D Price"
    "mgrosz"   = "M Grosz"
    "jcomey"   = "J Comey"
    "lfreiman" = "L Freiman"
    "kfranks" = "K Franks"
    "cnarducc" = "C Narducci"
    "cnarducci" = "C Narducci"
    "jloya" = "J Loya"
    "zmcdade" = "Z McDade"
    "rgrace" = "R Grace"
    "rpitingolo" = "R Pitingolo"
    "rpitingo" = "R Pitingolo"
    "slitschwartz" = "S Litschwartz"
    "slitschw" = "S Litschwartz"
    "blosoya" = "B Losoya"
    "sizhang" = "S Zhang"
    "mwoluchem" = "M Woluchem"
    "kabazajian" = "K Abazajian"
  ;

run;

proc catalog catalog=Metadata.formats;
  modify creator (desc="File creator names") / entrytype=formatc;
  contents;
quit;

run;

proc format library=Metadata fmtlib;
  select $creator;
run;

