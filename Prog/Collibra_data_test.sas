/**************************************************************************
 Program:  Collibra_data_test.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  11/28/16
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Test exporting NIDC metadata to Collibra.
 Data sets

 Modifications:
**************************************************************************/

%include "L:\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata, local=n )

%let Library_select = POLICE;
%let File_select = CRIMES_2;

%let RRCATMAX = 10;
%let FVALMAX = 100;

%let date_fmts =
  "/DATE/DATEAMPM/DATETIME/DAY/DDMMYY/" ||
  "/DDMMYYB/DDMMYYC/DDMMYYD/DDMMYYN/DDMMYYP/DDMMYYS/" ||
  "/DOWNAME/DTDATE/DTMONYY/DTWKDATX/DTYEAR/DTYYQC/" ||
  "/EURDFDD/EURDFDE/EURDFDN/EURDFDT/EURDFDWN/EURDFMN/EURDFMY/EURDFWDX/EURDFWKX/" ||
  "/HDATE/HEBDATE/HHMM/HOUR/JULDAY/JULIAN/MINGUO/MMDDYY/" ||
  "/MMDDYYB/MMDDYYC/MMDDYYD/MMDDYYN/MMDDYYP/MMDDYYS/" ||
  "/MMSS/MMYY/" ||
  "/MMYYC/MMYYD/MMYYN/MMYYP/MMYYS/" ||
  "/MONNAME/MONTH/MONYY/NENGO/NLDATE/NLDATEMN/NLDATEW/NLDATEWN/NLDATM/NLDATMAP/" ||
  "/NLDATMTM/NLDATMW/NLTIMAP/NLTIME/PDJULG/PDJULI/QTR/QTRR/TIME/TIMEAMPM/" ||
  "/TOD/WEEKDATE/WEEKDATX/WEEKDAY/WEEKU/WEEKV/WEEKW/WORDDATE/WORDDATX/YEAR/YYMM/" ||
  "/YYMMC/YYMMD/YYMMN/YYMMP/YYMMS/" ||
  "/YYMMDD/" ||
  "/YYMMDDB/YYMMDDC/YYMMDDD/YYMMDDN/YYMMDDP/YYMMDDS/" ||
  "/YYMON/YYQ/" ||
  "/YYQC/YYQD/YYQN/YYQP/YYQS/" ||
  "/YYQR/" ||
  "/YYQRC/YYQRD/YYQRN/YYQRP/YYQRS/";

** Process categorical var info **;

data Cat_vars;

  set Metadata.Meta_fval;
  by Library FileName VarNameUC;
  where upcase(Library) = "%upcase(&Library_select)" and upcase(FileName) =: "%upcase(&File_select)";
  
  length Fval_val1-Fval_val&FVALMAX $ 40 Fval_fval1-Fval_fval&FVALMAX $ 80;
  
  retain Fval_val1-Fval_val&FVALMAX Fval_fval1-Fval_fval&FVALMAX Fval_freq1-Fval_freq&FVALMAX;
  
  array Fval_val{*} Fval_val1-Fval_val&FVALMAX;
  array Fval_fval{*} Fval_fval1-Fval_fval&FVALMAX;
  array Fval_freq{*} Fval_freq1-Fval_freq&FVALMAX;
  
  retain Fval_count;
  
  if first.VarNameUC then do;
    Fval_count = 0;
    do i = 1 to dim( Fval_val );
      Fval_val{i} = "";
      Fval_fval{i} = "";
      Fval_freq{i} = .;
    end;
  end;
  
  Fval_count + 1;
  
  if Fval_count > &FVALMAX then do;
    %err_put( msg="Maximum number of formatted values (&FVALMAX) exceeded. " Library= FileName= VarName= )
    abort;
  end;
  
  Fval_val{Fval_count} = Value;
  Fval_fval{Fval_count} = FmtValue;
  Fval_freq{Fval_count} = Frequency;
  
  if last.VarNameUC then do;
    output;
  end;
  
  keep Library FileName VarNameUC MaxFmtVals Fval_: ;
  
run;

proc sort data=Cat_vars;
  by Library FileName descending VarNameUC;
run;


** Resort variable metadata **;

proc sort data=Metadata.Meta_vars out=Meta_vars;
  where upcase(Library) = "%upcase(&Library_select)" and upcase(FileName) =: "%upcase(&File_select)";
  by Library FileName descending VarNameUC;


** Combine variable and value metadata **;

data All_vars;

  merge
    Meta_vars (keep=Library FileName VarName VarNameUC VarDesc VarFmt _desc_:) 
    Cat_vars;
  by Library FileName descending VarNameUC;
  
  if not( missing( _desc_n ) ) or Fval_count > 0;
  
run;

%Dup_check(
  data=All_vars,
  by=Library FileName VarNameUC,
  id=,
  out=_dup_check,
  listdups=Y,
  count=dup_check_count,
  quiet=N,
  debug=N
)


** Create export file **;

data Data_test;

  length
    Type $ 40
    LastUpdated 8
    TimeCoveragePeriodStartDate 8
    TimeCoveragePeriodEndDate 8
    Community $ 40
    DomainType $ 40
    Domain $ 40
    Name $ 80
    PrimaryContact $ 40
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
    CategoricalVariableDescriptors $ 32767
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
    LastUpdated
    TimeCoveragePeriodStartDate
    TimeCoveragePeriodEndDate
    PrimaryContact 
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
  
  merge 
    Metadata.Meta_files 
    All_vars;
  by Library FileName;
  where upcase(Library) = "%upcase(&Library_select)" and upcase(FileName) =: "%upcase(&File_select)";
  
  Name = trim( propcase( Library ) ) || '.' || propcase( FileName );
  LastUpdated = datepart( FileUpdated );

  Description = FileDesc;
  
  Library = propcase( Library );
  
  **** HARD CODING THESE FIELDS FOR NOW, WILL WANT TO CHANGE LATER ****;

  TimeCoveragePeriodStartDate = '01jan2000'd;
  TimeCoveragePeriodEndDate = '31dec2015'd;

  PrimaryContact = "P Tatian";
  
  FrequencyofUpdate = "Annual";
  ClByGeoLevelGeographicLevel = "Not on this list";

  ClByRestrictionRestriction = "Public";

  select( lowcase( scan( FileName, -1, '_' ) ) );
    when ( "anc02" )
      Unitsofobservation = "Advisory Neighborhood Commission (2002)";
    when ( "anc12" )
      Unitsofobservation = "Advisory Neighborhood Commission (2012)";
    when ( "city" ) do;
      Unitsofobservation = "City total";
      ClByGeoLevelGeographicLevel = "City/Census Designated Place";
    end;
    when ( "cl00" ) do;
      Unitsofobservation = "Neighborhood cluster (2000)";
      ClByGeoLevelGeographicLevel = "Neighborhood";
    end;
    when ( "cltr00" ) do;
      Unitsofobservation = "Neighborhood cluster (tract-based, 2000)";
      ClByGeoLevelGeographicLevel = "Neighborhood";
    end;
    when ( "eor" )
      Unitsofobservation = "East of the Anacostia River";
    when ( "tr00" ) do;
      Unitsofobservation = "Census tract (2000)";
      ClByGeoLevelGeographicLevel = "Census Tract";
    end;
    when ( "tr10" ) do;
      Unitsofobservation = "Census tract (2010)";
      ClByGeoLevelGeographicLevel = "Census Tract";
    end;
    when ( "bg00" )
      Unitsofobservation = "Census block group (2000)";
    when ( "bg10" )
      Unitsofobservation = "Census block group (2010)";
    when ( "bl00" )
      Unitsofobservation = "Census block (2000)";
    when ( "bl10" )
      Unitsofobservation = "Census block (2010)";
    when ( "psa04" ) do;
      Unitsofobservation = "Police Service Area (2004)";
      ClByGeoLevelGeographicLevel = "Police District";
    end;
    when ( "psa12" ) do;
      Unitsofobservation = "Police Service Area (2012)";
      ClByGeoLevelGeographicLevel = "Police District";
    end;
    when ( "vp12" ) do;
      Unitsofobservation = "Voting Precinct (2012)";
      ClByGeoLevelGeographicLevel = "Voting District";
    end;
    when ( "wd02" )
      Unitsofobservation = "Ward (2002)";
    when ( "wd12" )
      Unitsofobservation = "Ward (2012)";
    when ( "zip" )
      Unitsofobservation = "ZIP code (5 digit)";
    when ( "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006", "2005", "2004", "2003", "2002", "2001", "2000" ) do;
      Unitsofobservation = "Reported crime incident";
      ClByGeoLevelGeographicLevel = "Latitude/Longitude";
      File_year = input( scan( FileName, -1, '_' ), 16. );
      TimeCoveragePeriodStartDate = mdy( 1, 1, File_year );
      TimeCoveragePeriodEndDate = mdy( 12, 31, File_year );
    end;
    otherwise do;
      %err_put( msg="GEOGRAPHY NOT FOUND!" )
      Unitsofobservation = "Unknown";
    end;
  end;

  Originaldatasourceinformation = "DC Open Data";
  URLoforiginaldatasource = '<a href="http://opendata.dc.gov/">opendata.dc.gov/</a>';
  ProjectCode = "";
  
  UniverseTargetPopulation = "Reported part 1 crimes, DC";
  Individualdatasetsinseries = "";
  
  LocationtoAccesstheData = "SAS1 server, DCData/Libraries/" || left( propcase( Library ) );
  
  AdditionalNotes = "";

  ConsiderationsorLimitations = "";
  CommentsonDataQuality = "";
  LinktoDataUseAgreementorMOU = "";
  
  **** END HARD CODING ****************************************************;
  
  ** Numeric variable descriptive stats **;
  
  if not( missing( _desc_n ) ) then do;
  
    if VarFmt ~= "" and index( %upcase(&date_fmts), compress( "/" || VarFmt || "/" ) ) then do;

      ** Variable is a date value **;
    
      NumericVariableDescriptors = 
      
        "<table style=""border-collapse: collapse;"">" ||
        
        "<tr>" ||
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">" ||
        trim( VarDesc ) || " [SAS date value]" ||
        "</th>" ||
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">N</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Mean</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">StdDev (days)</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Min</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Max</th>" || 
        "</tr>" ||

        "<tr>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( VarName ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( put( _desc_n, comma16. ) ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( put( _desc_mean, mmddyy10. ) ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( _desc_std ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( put( _desc_min, mmddyy10. ) ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( put( _desc_max, mmddyy10. ) ) ) ||
        "</td>" ||
        "</tr>" ||
        
        "</table>"
      ;
      
    end;
    else do;
    
      ** Variable not a date value **;
    
      NumericVariableDescriptors = 
      
        "<table style=""border-collapse: collapse;"">" ||
        
        "<tr>" ||
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">" ||
        trim( VarDesc ) ||
        "</th>" ||
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">N</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Sum</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Mean</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">StdDev</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Min</th>" || 
        "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Max</th>" || 
        "</tr>" ||

        "<tr>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( VarName ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( put( _desc_n, comma32. ) ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( _desc_sum ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( _desc_mean ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( _desc_std ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( _desc_min ) ) ||
        "</td>" ||
        "<td style=""padding: 2px 10px 2px 10px;"">" ||
        trim( left( _desc_max ) ) ||
        "</td>" ||
        "</tr>" ||
        
        "</table>"
      ;
      
    end;    
      
  end;
  
  ** Categorical variable value descriptors **;
  
  array Fval_val{*} Fval_val1-Fval_val&FVALMAX;
  array Fval_fval{*} Fval_fval1-Fval_fval&FVALMAX;
  array Fval_freq{*} Fval_freq1-Fval_freq&FVALMAX;
  
  if Fval_count > 0 then do;

    CategoricalVariableDescriptors = 

      "<table style=""border-collapse: collapse;"">" ||
      
      "<tr>" ||
      "<th style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"" colspan=""3"">" ||
      trim( VarName ) || " - " || trim( VarDesc ) ||
      "</th></tr><tr>" ||
      "<th align=""left"" style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Value</th>" || 
      "<th align=""left"" style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">Formatted value (" || trim(VarFmt) || ")</th>" || 
      "<th align=""left"" style=""border-bottom: 1px solid #000; padding: 2px 10px 2px 10px;"">N</th>" || 
      "</tr>";
      
    do i = 1 to Fval_count;  /**** TEMPORARY FIX: NEED TO SOLVE TRUNCATION PROBLEM ****/
    
      if mod( i, 2 ) then do;
    
        CategoricalVariableDescriptors = trim( CategoricalVariableDescriptors ) ||
          "<tr>" ||
          "<td style=""padding: 2px 10px 2px 10px;"">" ||
          trim( Fval_val{i} ) ||
          "</td>" ||
          "<td style=""padding: 2px 10px 2px 10px;"">" ||
          trim( Fval_fval{i} ) ||
          "</td>" ||
          "<td style=""padding: 2px 10px 2px 10px;"">" ||
          trim( left( Fval_freq{i} ) ) ||
          "</td>" ||
          "</tr>"
        ;
        
      end;
      else do;
        
        CategoricalVariableDescriptors = trim( CategoricalVariableDescriptors ) ||
          "<tr>" ||
          "<td style=""background-color: #EEE; padding: 2px 10px 2px 10px;"">" ||
          trim( Fval_val{i} ) ||
          "</td>" ||
          "<td style=""background-color: #EEE; padding: 2px 10px 2px 10px;"">" ||
          trim( Fval_fval{i} ) ||
          "</td>" ||
          "<td style=""background-color: #EEE; padding: 2px 10px 2px 10px;"">" ||
          trim( left( Fval_freq{i} ) ) ||
          "</td>" ||
          "</tr>"
        ;
              
      end;
      
    end;
      
    if MaxFmtVals > 0 then do;
    
      CategoricalVariableDescriptors = trim( CategoricalVariableDescriptors ) ||
        "<tr>" ||
        "<td align=""left"" style=""padding: 2px 10px 2px 10px;"" colspan=""3""><i>Only first " || trim( left( MaxFmtVals ) ) || " values shown.</i>" ||
        "</td>" ||
        "</tr>"
      ;
      
    end;
    
    CategoricalVariableDescriptors = trim( CategoricalVariableDescriptors ) || "</table>";
    
  end;
    
  if first.Filename then do;
  
    ClByRRCategoryRRCategory = "";
    
    ** Generate output obs for each R&R category, numeric var, and categorical var **;
    
    array _RRCat{*} _RRCat1-_RRCat&RRCATMAX;
    
    _RRCategories = "Neighborhoods, Cities, and Metros|Crime and Justice";
    
    ** Parse R&R categories **;
    
    do i = 1 to &RRCATMAX;
      _RRCat{i} = scan( _RRCategories, i, '|' );
      if _RRCat{i} = "" then leave;
    end;
    
    _RRCatNum = i - 1;

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
    PrimaryContact = "Primary Contact"
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
    PrimaryContact
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

%File_info( data=Data_test, printobs=0 )

/*
filename fexport "Collibra_Data_test.csv" lrecl=5000;

proc export data=Data_test
    outfile=fexport
    dbms=csv label replace;

run;

filename fexport clear;
*/

ods csvall body="Collibra_data_test.csv";
ods listing close;

title;
footnote;
options missing=' ';

proc print data=Data_test label noobs;
run;

ods csvall close;
ods listing;

