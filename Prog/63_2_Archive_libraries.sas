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

options noxwait xmin;


** Archive entire library **;
%Archive_metadata_lib( ds_lib=ACIP, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=DCCASH, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=NAS, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=COMMFND, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=NPROFITS, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=WAWF, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=DYOUTH, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=HSNGMON, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=CORELOG, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=MRIS, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=VOICES, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=DCOLA, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_lib( ds_lib=REGHSG, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )

run;
