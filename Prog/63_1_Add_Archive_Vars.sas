/**************************************************************************
 Program:  63_1_Add_Archive_Vars.sas
 Library:  Metadata
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  03/06/25
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  63
 
 Description:  Add MetadataLibArchive and MetadataFileArchive vars
 to meta_libs and meta_files data sets. 

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata )

data Metadata.meta_libs;

  set Metadata.meta_libs;
  
  length MetadataLibArchive 3;
  
  retain MetadataLibArchive 0;
  
  label MetadataLibArchive = "Metadata for library has been archived (1=Yes)";

run;

%File_info( data=Metadata.meta_libs, printobs=0 )


data Metadata.meta_files;

  set Metadata.meta_files;
  
  length MetadataFileArchive 3;
  
  retain MetadataFileArchive 0;
  
  label MetadataFileArchive = "Metadata for file has been archived (1=Yes)";

run;

%File_info( data=Metadata.meta_files, printobs=0 )

