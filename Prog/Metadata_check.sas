/**************************************************************************
 Program:  Metadata_check.sas
 Library:  Metadata
 Project:  Urban-Greater DC
 Author:   P. Tatian
 Created:  02/24/25
 Version:  SAS 9.4
 Environment:  Local Windows session (desktop)
 GitHub issue:  63
 
 Description:  Run checks on metadata files to see where reductions
could be made. 

 Modifications:
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

data meta_files;

  set Metadata.meta_files;
  **where Library in ( "ACIP", "PRESCAT" );
  
  FileUpdated_dt = datepart( FileUpdated );
  
  if upcase( FileFmt ) in ( 'SAS/V8', 'SAS/V9' ) then 
    FileExists = fileexist(cats("&_dcdata_r_path\",Library,"\Data\",Filename,".sas7bdat")); 
  else
    FileExists = fileexist(cats("&_dcdata_r_path\",Library,"\Data\",Filename,".sas7bvew")); 
    
  NotFileExists = not( FileExists );
  
  format FileUpdated_dt mmddyy10.;
  
run;

/*
proc freq data=meta_files;
  tables FileExists NotFileExists;
run;

proc print data=meta_files (obs=100);
  id Library Filename;
  var FileExists NotFileExists;
run;
*/

proc freq data=meta_files;
  tables FileUpdated_dt;
  format FileUpdated_dt year4.;
run;

proc summary data=meta_files nway;
  class library;
  var FileUpdated_dt FileExists NotFileExists;
  output out=meta_files_by_lib (drop=_type_ rename=(_freq_=NumFiles)) 
    min(FileUpdated_dt)= 
    max(FileUpdated_dt)= 
    sum(FileExists NotFileExists)=FileExists NotFileExists
    /autoname;
run;

/*
proc print data=meta_files_by_lib;
  id Library;
run;
*/

proc summary data=Metadata.meta_fval nway;
  **where Library in ( "ACIP", "PRESCAT" );
  class library;
  output out=meta_fval_by_lib (drop=_type_ rename=(_freq_=NumFVals));
run;


proc summary data=Metadata.meta_vars nway;
  **where Library in ( "ACIP", "PRESCAT" );
  class library;
  output out=meta_vars_by_lib (drop=_type_ rename=(_freq_=NumVars));
run;

data Library_sum;

  merge 
    meta_files_by_lib
    meta_vars_by_lib
    meta_fval_by_lib;
  by library;
  
  if missing( NumFVals ) then NumFVals = 0;

run;
    

** Library summary report **;
    
proc sort data=Library_sum;
  by FileUpdated_dt_max;
run;

ods csvall body="&_dcdata_default_path\Metadata\Prog\Metadata_check_Library_sum.csv";

proc print data=Library_sum label;
  id library;
  format 
    Num: FileExists NotFileExists comma12.;
  label 
    NumFiles = "Files"
    Numvars = "Variables"
    FileExists = "Files saved on SAS1"
    NotFileExists = "Files not saved on SAS1";
run;

ods csvall close;


** List files not saved on SAS1 **;

ods csvall body="&_dcdata_default_path\Metadata\Prog\Metadata_check_NotFileExists.csv";
ods listing close;

proc print data=meta_files;
  where NotFileExists;
  by library;
  id FileName;
  var FileUpdated_dt FileDesc;
run;

ods csvall close;
ods listing;



