/**************************************************************************
 Program:  63_3_Archive_files.sas
 Library:  Metadata
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  03/06/25
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  63
 
 Description:  Archive metdata for files over 1,800 days old in DCDATA.

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata )

options noxwait xmin;

%Archive_metadata_file( ds_lib=CTPP, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=BPERMITS, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )

run;
