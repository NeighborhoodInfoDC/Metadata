************************************************************************
  Program:  DC_create_meta_html_remote.sas
  Library:  Metadata
  Project:  DC Data Warehouse
  Author:   P. Tatian
  Created:  11/11/04
  Version:  SAS 9.2
  Environment:  Remote Windows session (SAS1)
  
  Description:  Create metadata HTML files.
 
  Modifications:
   04/01/05 - Now automatically uploads files to web server.
   03/10/08   Added parameter for creating updates page. 
   03/06/09   Added parameters for formatting Creator names and 
              for creating RSS update feed.
   10/12/11 PAT Added email notification for start, finish, errors.
   13/14/14 PAT Updated for new SAS1 server.
************************************************************************;

%include "F:\DCData\SAS\Inc\StdRemote.sas";

** Define libraries **;
%DCData_lib( Metadata )

options noxwait;
x "del /q &_dcdata_r_drive:\DCData\Metadata\*.html";

/*************************
%** Email addresses for notification **;
%macro set_notify();
%global notify;
%put _userid=&_userid;
%if %lowcase( &_userid ) = ptatian or %lowcase( &_userid ) = dcdata_pat %then
  %let notify = ptatian@urban.org;
%else
  %let notify = &_userid@urban.org ptatian@urban.org;
%mend set_notify;
%set_notify()
*******************************/

/********************************
%macro notify_start( notify );
%** Notify by email of metadata update start **;
%if %length( &notify ) > 0 %then %do;

  %if &SYSSCP = WIN %then %do;
    %Warn_mput( macro=Update_metadata_file, msg=Email notification (NOTIFY=) is only available in Alpha environment. )
  %end;
  %else %do;
    %let i = 1;
    %let em = %scan( &notify, &i, %str( ) );
    %do %until ( &em = );
      %note_mput( macro=Update_metadata_file, msg=Email notification being sent to &em.. )
      X mail /subject="Metadata HTML update started." nl: "&em";
      %let i = %eval( &i + 1 );
      %let em = %scan( &notify, &i, %str( ) );
    %end;
  %end;

%end;
%mend notify_start;

%notify_start( &notify )
****************************************/

%Create_metadata_html( 
         meta_lib= metadata,
         meta_pre= meta,
         meta_title= NeighborhoodInfo DC Metadata System,
         update_months= 12,
         rss= n,
         rss_url= ,
         creator_fmt= $creator.,
         html_folder= &_dcdata_r_drive:\DCData\Metadata\,
         html_pre= meta,
         html_suf= html,
         html_title= NeighborhoodInfo DC Metadata -,
         html_stylesht= metadata_style.css,
         error_notify=
       )

run;

/*************************************
** FTP files to web server **;

options xwait;
x "ftp /input=[dcdata.metadata.prog]metadata_delete.ftp";
x "ftp /input=[dcdata.metadata.prog]metadata_copy.ftp";

%macro notify_finish( notify );
%** Notify by email of metadata update finish **;
%if %length( &notify ) > 0 %then %do;

  %if &SYSSCP = WIN %then %do;
    %Warn_mput( macro=Update_metadata_file, msg=Email notification (NOTIFY=) is only available in Alpha environment. )
  %end;
  %else %do;
    %let i = 1;
    %let em = %scan( &notify, &i, %str( ) );
    %do %until ( &em = );
      %note_mput( macro=Update_metadata_file, msg=Email notification being sent to &em.. )
      X mail /subject="Metadata HTML update complete." nl: "&em";
      %let i = %eval( &i + 1 );
      %let em = %scan( &notify, &i, %str( ) );
    %end;
  %end;

%end;

%mend notify_finish;

%notify_finish( &notify )
***********************************************/

run;
