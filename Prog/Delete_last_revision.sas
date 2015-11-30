/**************************************************************************
 Program:  Delete_last_revision.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  04/25/08
 Version:  SAS 9.1
 Environment:  Windows with SAS/Connect
 
 Description:  Delete the specified data set's last revision entry
 from the metadata file history.

 NB: This should not be run if there is only one history entry for
 the data set. Run %Delete_metadata_files() instead.

 Modifications:
  04/15/09 PAT Added after= parameter. 
  10/05/15 PAT Updated for SAS1.
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )


/** Macro Delete_last_revision - Start Definition **/

%macro Delete_last_revision( 
  library=,      /** Library name **/
  filename=,     /** Data set name **/
  before=,        /** SAS date value: If specified, 
                     delete all revision entries BEFORE this date. **/
  after=         /** SAS date value: If specified, 
                     delete all revision entries AFTER this date. **/
);

  %let library = %upcase( &library );
  %let filename = %upcase( &filename );

  options obs=max;

  proc print data=Metadata.Meta_history noobs;
    where library = "&library" and filename = "&filename";
    by library filename;
    var FileUpdated FileRevisions;
    title2 "Meta_history - BEFORE deletion";
    
  run;

  data Metadata.Meta_history;

    set Metadata.Meta_history;
    by library filename descending FileUpdated;

    if library = %upcase( "&library" ) and filename = %upcase( "&filename" ) and 
        %if &before ~= and &after ~= %then %do;
          ( &before > datepart( FileUpdated ) > &after ) /** Delete all revisions before and after specified dates **/
        %end;
        %else %if &before ~= %then %do;
          ( &before > datepart( FileUpdated ) ) /** Delete all revisions before specified date **/
        %end;
        %else %if &after ~= %then %do;
          ( datepart( FileUpdated ) > &after ) /** Delete all revisions after specified date **/
        %end;
        %else %do;
          first.filename /** Delete last revision only **/
        %end;
      then do;
        %note_put( msg="Deleting observation from Meta_history: "      
                        _n_= library= filename= FileUpdated= FileRevisions= )
        delete;
    end;

  run;

  proc print data=Metadata.Meta_history noobs;
    where library = "&library" and filename = "&filename";
    by library filename;
    var FileUpdated FileRevisions;
    title2 "Meta_history - AFTER deletion";
    
  run;

%mend Delete_last_revision;

/** End Macro Definition **/


%Delete_last_revision( library=PresCat, filename=Subsidy )

run;

