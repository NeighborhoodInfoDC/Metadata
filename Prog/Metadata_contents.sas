/**************************************************************************
 Program:  Metadata_contents.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  08/07/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Run Proc Contents on metadata data sets.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

proc contents data=Metadata.meta_files;
proc contents data=Metadata.meta_fval;
proc contents data=Metadata.meta_history;
proc contents data=Metadata.meta_libs;
proc contents data=Metadata.meta_vars;

run;
