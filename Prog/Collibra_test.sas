/**************************************************************************
 Program:  Collibra_test.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/28/16
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Test exporting NIDC metadata to Collibra.

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

%let RRCATMAX = 10;

data Test;

  length
    Type $ 40
    LastUpdated 8
    TimeCoveragePeriodStartDate 8
    TimeCoveragePeriodEndDate 8
    Community $ 40
    DomainType $ 40
    Domain $ 40
    Name $ 40
    RolesPrimaryContactFirstName $ 40
    RolesPrimaryContactLastName $ 40
    RolesPrimaryContactUserName $ 40
    FrequencyofUpdate $ 40
    ClByGeoLevelType $ 40
    ClByGeoLevelCommunity $ 40
    ClByGeoLevelDomainType $ 40
    ClByGeoLevelDomain $ 40
    ClByGeoLevelGeographicLevel $ 40
    AvailableinDataFormatType $ 40
    AvailableinDataFormatCommunity $ 40
    AvailableinDataFormatDomainType $ 40
    AvailableinDataFormatDomain $ 40
    AvailableinDataFormatDataFormat $ 40
    ClByRRCategoryType $ 40
    ClByRRCategoryCommunity $ 40
    ClByRRCategoryDomainType $ 40
    ClByRRCategoryDomain $ 40
    ClByRRCategoryRRCategory $ 40
    ClByDataValueType $ 40
    ClByDataValueCommunity $ 40
    ClByDataValueDomainType $ 40
    ClByDataValueDomain $ 40
    ClByDataValueDataValue $ 40
    ClByRestrictionType $ 40
    ClByRestrictionCommunity $ 40
    ClByRestrictionDomainType $ 40
    ClByRestrictionDomain $ 40
    ClByRestrictionRestriction $ 40
    Status $ 40
    Description $ 2000
    Unitsofobservation $ 40
    Originaldatasourceinformation $ 40
    URLoforiginaldatasource $ 1000
    ProjectCode $ 40
    UniverseTargetPopulation $ 40
    Individualdatasetsinseries $ 40
    Cost $ 40
    InstructionstoAccesstheData $ 40
    LocationtoAccesstheData $ 40
    LicensingCitation $ 40
    AdditionalNotes $ 40
    AssociatedPublications $ 2000
    LinkstoPublications $ 1000
    ConsiderationsorLimitations $ 2000
    CommentsonDataQuality $ 2000
    LinktoDataUseAgreementorMOU $ 40
    AdditionalTags $ 40
    LinktoDataDictionaryPDF $ 1000
    Library $ 32
    NumericVariableDescriptors $ 2000
    CategoricalVariableDescriptors $ 2000
  ;
  
  ** Constant value variables (same for all data sets) **;
  
  retain
    Type "Data Set"
    Community "NeighborhoodInfo DC"
    DomainType "Data Usage Registry"
    Domain "Data Sets"
    ClByGeoLevelType "Geographic Level"
    ClByGeoLevelCommunity "Urban Institute"
    ClByGeoLevelDomainType "Business Dimensions"
    ClByGeoLevelDomain "Urban Data Classifications"
    AvailableinDataFormatType "Data Format"
    AvailableinDataFormatCommunity "Urban Institute"
    AvailableinDataFormatDomainType "Business Dimensions"
    AvailableinDataFormatDomain "Urban Data Classifications"
    AvailableinDataFormatDataFormat "SAS"
    ClByRRCategoryType 'R&R Category'
    ClByRRCategoryCommunity "Urban Institute"
    ClByRRCategoryDomainType "Business Dimensions"
    ClByRRCategoryDomain "Urban Data Classifications"
    ClByDataValueType "Data Value"
    ClByDataValueCommunity "Urban Institute"
    ClByDataValueDomainType "Business Dimensions"
    ClByDataValueDomain "Urban Data Classifications"
    ClByDataValueDataValue "Medium"
    ClByRestrictionType "Restriction"
    ClByRestrictionCommunity "Urban Institute"
    ClByRestrictionDomainType "Business Dimensions"
    ClByRestrictionDomain "Urban Data Classifications"
    Status "Approved"
    Cost "Free"
    InstructionstoAccesstheData "Email NeighborhoodInfoDC@urban.org"
    LicensingCitation ""
    AssociatedPublications ""
    LinkstoPublications ""
    AdditionalTags ""
    LinktoDataDictionaryPDF ""
  ;

  ** Data set specific value variables **;
  
  retain
    Type
    LastUpdated
    TimeCoveragePeriodStartDate
    TimeCoveragePeriodEndDate
    RolesPrimaryContactFirstName
    RolesPrimaryContactLastName 
    RolesPrimaryContactUserName
    FrequencyofUpdate 
    ClByGeoLevelGeographicLevel 
    ClByRRCategoryRRCategory
    ClByRestrictionRestriction
    Description 
    Unitsofobservation 
    Originaldatasourceinformation 
    URLoforiginaldatasource 
    ProjectCode 
    UniverseTargetPopulation 
    Individualdatasetsinseries 
    LocationtoAccesstheData 
    AdditionalNotes 
    ConsiderationsorLimitations 
    CommentsonDataQuality 
    LinktoDataUseAgreementorMOU 
    Library
  ;
  
  ** Processing vars **;

  length _RRCategories _RRCat1-_RRCat&RRCATMAX $ 80;
  
  retain 
    _RRCategories 
    _RRCat1-_RRCat&RRCATMAX
    _RRCatNum
  ;
  
  set Metadata.Meta_files;
  by Library FileName;
  where upcase(Library) = "POLICE" and upcase(FileName) = "CRIMES_SUM_ANC12";
  
  Name = propcase( FileName );
  LastUpdated = datepart( FileUpdated );

  TimeCoveragePeriodStartDate = '01jan2000'd;
  TimeCoveragePeriodEndDate = '31dec2011'd;

  **** HARD CODING THIS FOR NOW, BUT MAY WANT TO CHANGE LATER ****;
  RolesPrimaryContactFirstName = "P";        
  RolesPrimaryContactLastName = "Tatian";
  RolesPrimaryContactUserName = "Peter";
  
  FrequencyofUpdate = "Annual";
  ClByGeoLevelGeographicLevel = "Not on this list";

  ClByRestrictionRestriction = "Public";

  Description = FileDesc;
  Unitsofobservation = "Advisory Neighborhood Commission (2012)";

  Originaldatasourceinformation = "DC Open Data";
  URLoforiginaldatasource = '<a href="http://opendata.dc.gov/"></a>';
  ProjectCode = "";
  
  UniverseTargetPopulation = "Reported part 1 crimes, DC";
  Individualdatasetsinseries = "";
  
  LocationtoAccesstheData = "SAS1 server, DCData/Libraries/Police";
  
  AdditionalNotes = "";

  ConsiderationsorLimitations = "";
  CommentsonDataQuality = "";
  LinktoDataUseAgreementorMOU = "";
  
  Library = propcase( Library );
  
  
  ** Generate output obs for each R&R category, numeric var, and categorical var **;
  
  array _RRCat{*} _RRCat1-_RRCat&RRCATMAX;
  
  _RRCategories = "Neighborhoods, Cities, and Metros|Crime and Justice";
  
  ** Parse R&R categories **;
  
  do i = 1 to &RRCATMAX;
    _RRCat{i} = scan( _RRCategories, i, '|' );
    if _RRCat{i} = "" then leave;
  end;
  
  _RRCatNum = i - 1;
  PUT _RRCATNUM=;

  NumericVariableDescriptors = "";

  CategoricalVariableDescriptors = "<table style=""border-collapse: collapse;"">" ||
  "<tr><th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Variable</th><th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">N</th></tr>" ||
  "<tr><td style=""padding: 2px 10px 2px 10px;"">Ward</td><td style=""padding: 2px 10px 2px 10px;"">1</td></tr>" ||
  "<tr><td style=""background-color: #EEE; padding: 2px 10px 2px 10px;"">Ward</td><td style=""background-color: #EEE; padding: 2px 10px 2px 10px;"">2</td></tr>" ||
  "<tr><td style=""padding: 2px 10px 2px 10px;"">Ward</td><td style=""padding: 2px 10px 2px 10px;"">3</td></tr>" ||
  "<tr><td style=""background-color: #EEE; padding: 2px 10px 2px 10px;"">Ward</td><td style=""background-color: #EEE; padding: 2px 10px 2px 10px;"">4</td></tr>" ||
  "</table>"
  ;
  
  if first.Filename then do;
  
    ClByRRCategoryRRCategory = "";
    
  end;
  
  if last.FileName then do;
  
    if _RRCatNum > 0 then do;
      do i = _RRCatNum to 1 by -1;
        ClByRRCategoryRRCategory = _RRCat{i};
        output;
      end;
    end;
    else do;
      output;
    end;
    
  end;
  else do;
  
    if _RRCatNum > 0 then do;
      ClByRRCategoryRRCategory = _RRCat{_RRCatNum};
      _RRCatNum = _RRCatNum - 1;
    end;
    
    output;
    
  end;

  format 
    LastUpdated TimeCoveragePeriodStartDate TimeCoveragePeriodEndDate mmddyy10.;

  label
    Type = "Type"
    LastUpdated = "Last Updated"
    TimeCoveragePeriodStartDate = "Time Coverage Period Start Date"
    TimeCoveragePeriodEndDate = "Time Coverage Period End Date"
    Community = "Community"
    DomainType = "Domain Type"
    Domain = "Domain"
    Name = "Name"
    RolesPrimaryContactFirstName = "Roles > Primary Contact > First Name"
    RolesPrimaryContactLastName = "Roles > Primary Contact > Last Name"
    RolesPrimaryContactUserName = "Roles > Primary Contact > User Name"
    FrequencyofUpdate = "Frequency of Update"
    ClByGeoLevelType = "Classified by [Geographic Level] > Type"
    ClByGeoLevelCommunity = "Classified by [Geographic Level] > Community"
    ClByGeoLevelDomainType = "Classified by [Geographic Level] > Domain Type"
    ClByGeoLevelDomain = "Classified by [Geographic Level] > Domain"
    ClByGeoLevelGeographicLevel = "Classified by [Geographic Level] > Geographic Level"
    AvailableinDataFormatType = "Available in [Data Format] > Type"
    AvailableinDataFormatCommunity = "Available in [Data Format] > Community"
    AvailableinDataFormatDomainType = "Available in [Data Format] > Domain Type"
    AvailableinDataFormatDomain = "Available in [Data Format] > Domain"
    AvailableinDataFormatDataFormat = "Available in [Data Format] > Data Format"
    ClByRRCategoryType = 'Classified By [R&R Category] > Type'
    ClByRRCategoryCommunity = 'Classified By [R&R Category] > Community'
    ClByRRCategoryDomainType = 'Classified By [R&R Category] > Domain Type'
    ClByRRCategoryDomain = 'Classified By [R&R Category] > Domain'
    ClByRRCategoryRRCategory = 'Classified By [R&R Category] > R&R Category'
    ClByDataValueType = "Classified by [Data Value] > Type"
    ClByDataValueCommunity = "Classified by [Data Value] > Community"
    ClByDataValueDomainType = "Classified by [Data Value] > Domain Type"
    ClByDataValueDomain = "Classified by [Data Value] > Domain"
    ClByDataValueDataValue = "Classified by [Data Value] > Data Value"
    ClByRestrictionType = "Classified by [Restriction] > Type"
    ClByRestrictionCommunity = "Classified by [Restriction] > Community"
    ClByRestrictionDomainType = "Classified by [Restriction] > Domain Type"
    ClByRestrictionDomain = "Classified by [Restriction] > Domain"
    ClByRestrictionRestriction = "Classified by [Restriction] > Restriction"
    Status = "Status"
    Description = "Description"
    Unitsofobservation = "Unit(s) of observation"
    Originaldatasourceinformation = "Original data source information"
    URLoforiginaldatasource = "URL of original data source"
    ProjectCode = "Project Code"
    UniverseTargetPopulation = "Universe/Target Population"
    Individualdatasetsinseries = "Individual data sets in series"
    Cost = "Cost"
    InstructionstoAccesstheData = "Instructions to Access the Data"
    LocationtoAccesstheData = "Location to Access the Data"
    LicensingCitation = "Licensing/Citation"
    AdditionalNotes = "Additional Notes"
    AssociatedPublications = "Associated Publications"
    LinkstoPublications = "Links to Publications"
    ConsiderationsorLimitations = "Considerations or Limitations"
    CommentsonDataQuality = "Comments on Data Quality"
    LinktoDataUseAgreementorMOU = "Link to Data Use Agreement or Memorandum of Understanding"
    AdditionalTags = "Additional Tags"
    LinktoDataDictionaryPDF = "Link to Data Dictionary PDF"
    Library = "Library"
    NumericVariableDescriptors = "Numeric Variable Descriptors"
    CategoricalVariableDescriptors = "Categorical Variable Descriptors"
  ;

  keep
    Type
    LastUpdated
    TimeCoveragePeriodStartDate
    TimeCoveragePeriodEndDate
    Community
    DomainType
    Domain
    Name
    RolesPrimaryContactFirstName
    RolesPrimaryContactLastName
    RolesPrimaryContactUserName
    FrequencyofUpdate
    ClByGeoLevelType
    ClByGeoLevelCommunity
    ClByGeoLevelDomainType
    ClByGeoLevelDomain
    ClByGeoLevelGeographicLevel
    AvailableinDataFormatType
    AvailableinDataFormatCommunity
    AvailableinDataFormatDomainType
    AvailableinDataFormatDomain
    AvailableinDataFormatDataFormat
    ClByRRCategoryType
    ClByRRCategoryCommunity
    ClByRRCategoryDomainType
    ClByRRCategoryDomain
    ClByRRCategoryRRCategory
    ClByDataValueType
    ClByDataValueCommunity
    ClByDataValueDomainType
    ClByDataValueDomain
    ClByDataValueDataValue
    ClByRestrictionType
    ClByRestrictionCommunity
    ClByRestrictionDomainType
    ClByRestrictionDomain
    ClByRestrictionRestriction
    Status
    Description
    Unitsofobservation
    Originaldatasourceinformation
    URLoforiginaldatasource
    ProjectCode
    UniverseTargetPopulation
    Individualdatasetsinseries
    Cost
    InstructionstoAccesstheData
    LocationtoAccesstheData
    LicensingCitation
    AdditionalNotes
    AssociatedPublications
    LinkstoPublications
    ConsiderationsorLimitations
    CommentsonDataQuality
    LinktoDataUseAgreementorMOU
    AdditionalTags
    LinktoDataDictionaryPDF
    Library
    NumericVariableDescriptors
    CategoricalVariableDescriptors
  ;

run;

%File_info( data=Test )

/*
filename fexport "Collibra_test.csv" lrecl=5000;

proc export data=Test
    outfile=fexport
    dbms=csv label replace;

run;

filename fexport clear;
*/

ods csvall body="Collibra_test.csv";
ods listing close;

title;
footnote;
options missing=' ';

proc print data=Test label noobs;
run;

ods csvall close;
ods listing;

