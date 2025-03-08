************************************************************************
  Program:  DC_create_meta_html_remote.sas
  Library:  Metadata
  Project:  Urban-Greater DC
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

options noxwait xmin;
x "del /q &_dcdata_r_drive:\DCData\Metadata\*.html";


%Create_metadata_html( 
         meta_lib= metadata,
         meta_pre= meta,
         meta_title= Urban-Greater DC Metadata System,
         update_months= 12,
         rss= n,
         rss_url= ,
         creator_fmt= $creator.,
         html_folder= &_dcdata_r_drive:\DCData\Metadata\,
         html_link_folder=\\sas1\DCDATA\Metadata\,
         html_pre= meta,
         html_suf= html,
         html_title= Urban-Greater DC Metadata -,
         html_stylesht= metadata_style.css,
         error_notify=
       )

run;

