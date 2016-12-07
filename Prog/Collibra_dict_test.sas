/**************************************************************************
 Program:  Collibra_dict_test.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/28/16
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Test exporting NIDC metadata to Collibra.
 Data Dictionary

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

%let Library_select = POLICE;
%let File_select = CRIMES_2;

** Create export file **;

data Dict_test;

  length
    Type $ 40
    Community $ 40
    DomainType $ 40
    Domain $ 40
    Name $ 40
    Status $ 40
    Description $ 2000
    ispartofDataSetType $ 40
    ispartofDataSetCommunity $ 40
    ispartofDataSetDomainType $ 40
    ispartofDataSetDomain $ 40
    ispartofDataSetDataSet $ 80
  ;
  
  ** Constant value variables (same for all data sets) **;
  
  retain
    Type "Column"
    Community "NeighborhoodInfo DC"
    DomainType "Physical Data Directory"
    Domain "Data Dictionary"
    Status "Approved"
    ispartofDataSetType "Data Set"
    ispartofDataSetCommunity "NeighborhoodInfo DC"
    ispartofDataSetDomainType "Data Usage Registry"
    ispartofDataSetDomain "Data Sets"
  ;

  ** Column specific value variables **;
  
  retain
    Name
    Description
    ispartofDataSetDataSet
  ;
  
  set Metadata.Meta_vars (keep=Library FileName VarName VarDesc);
  by Library FileName;
  where upcase(Library) = "%upcase(&Library_select)" and upcase(FileName) =: "%upcase(&File_select)";
  
  Name = propcase( VarName );
  Description = VarDesc;
  ispartofDataSetDataSet = trim( propcase( Library ) ) || '.' || propcase( FileName );

  label
    Type = "Type"
    Community = "Community"
    DomainType = "Domain Type"
    Domain = "Domain"
    Name = "Name"
    Status = "Status"
    Description = "Description"
    ispartofDataSetType = "is part of [Data Set] > Type"
    ispartofDataSetCommunity = "is part of [Data Set] > Community"
    ispartofDataSetDomainType = "is part of [Data Set] > Domain Type"
    ispartofDataSetDomain = "is part of [Data Set] > Domain"
    ispartofDataSetDataSet = "is part of [Data Set] > Data Set"
  ;

  keep
    Type
    Community
    DomainType
    Domain
    Name
    Status
    Description
    ispartofDataSetType
    ispartofDataSetCommunity
    ispartofDataSetDomainType
    ispartofDataSetDomain
    ispartofDataSetDataSet
  ;

run;

%File_info( data=Dict_test, printobs=10, stats= )

ods csvall body="Collibra_dict_test.csv";
ods listing close;

title;
footnote;
options missing=' ';

proc print data=Dict_test label noobs;
run;

ods csvall close;
ods listing;

