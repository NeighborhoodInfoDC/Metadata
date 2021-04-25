/**************************************************************************
 Program:  Contents_metadata.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  01/08/15
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Display contents of metadata files.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata )

%File_info( data=Metadata.meta_libs, stats= )
%File_info( data=Metadata.meta_files, stats= )
%File_info( data=Metadata.meta_vars, stats= )
%File_info( data=Metadata.meta_fval, stats= )
%File_info( data=Metadata.meta_history, stats= )

run;
