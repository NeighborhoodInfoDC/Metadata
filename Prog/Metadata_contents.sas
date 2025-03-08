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

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

%File_info( data=Metadata.meta_libs, stats= )
%File_info( data=Metadata.meta_files, stats=, freqvars=FileFmt )
%File_info( data=Metadata.meta_history, stats= )
%File_info( data=Metadata.meta_vars, stats= )
%File_info( data=Metadata.meta_fval, stats= )

run;
