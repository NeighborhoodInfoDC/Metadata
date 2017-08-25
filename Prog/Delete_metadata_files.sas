/**************************************************************************
 Program:  Delete_metadata_files.sas
 Library:  Metadata
 Project:  DC Data Warehouse
 Author:   P. Tatian
 Created:  12/30/04
 Version:  SAS 8.2
 Environment:  Windows with SAS/Connect
 
 Description:  Delete files from metadata system.

 Modifications:
  09/02/15 PAT Update for SAS1 server.
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

/** Macro DC_delete_meta_file - Start Definition **/

%macro DC_delete_meta_file( 
         ds_lib= ,
         ds_name= ,
);

  %Delete_metadata_file(  
         ds_lib=&ds_lib,
         ds_name=&ds_name,
         meta_lib=_metadat,
         meta_pre=meta
  )

%mend DC_delete_meta_file;

/** End Macro Definition **/

run;


** Delete files from metadata system **;

%DC_delete_meta_file( ds_lib=ACS, ds_name=Acs_sf_2009_13_dc_bg10 )
%DC_delete_meta_file( ds_lib=ACS, ds_name=Acs_sf_2009_13_dc_tr10 )

run;

