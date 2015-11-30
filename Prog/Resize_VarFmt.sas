/**************************************************************************
 Program:  Resize_VarFmt.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/07/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Resize the VarFmt var in Metadata.Meta_vars to 32
 characters to be consistent with SAS 9.2 standards.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

data Metadata.Meta_vars_new;

  length VarFmt $ 32;
  
  set Metadata.Meta_vars;

run;

%File_info( data=Metadata.Meta_vars_new )

proc compare base=Metadata.Meta_vars compare=Metadata.Meta_vars_new maxprint=(40,32000);
run;

