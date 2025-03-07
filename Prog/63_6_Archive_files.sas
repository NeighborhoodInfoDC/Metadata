/**************************************************************************
 Program:  63_6_Archive_files.sas
 Library:  Metadata
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  03/07/25
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

%Archive_metadata_file( ds_lib=IPUMS, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=EQUITY, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=VITAL, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=CENSUS, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )

%Archive_metadata_file( ds_lib=VOTER, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=BRIDGEPK, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=ROD, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=TANF, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=CDC500, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=PLANNING, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=LEHD, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=SCHOOLS, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=AHS, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=HMDA, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=NCDB, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=GENERAL, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=HUD, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=MAR, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=REALPROP, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )
%Archive_metadata_file( ds_lib=POLICE, ds_days_old=1800, meta_lib=metadata, html_folder=\\sas1\DCDATA\Metadata\, html_pre=meta, html_suf=html )

run;
