/**************************************************************************
 Program:  63_2_Archive_libraries.sas
 Library:  Metadata
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  03/06/25
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  63
 
 Description:  Archive entire metadata libraries for DCDATA.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata )

** Archive entire library **;
%Archive_metadata_lib( 
         ds_lib=ACIP,
         meta_lib=metadata,
         html_folder= \\sas1\DCDATA\Metadata\,
         html_pre= meta,
         html_suf= html
       );


run;
