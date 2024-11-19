/**************************************************************************
 Program:  Register_libraries.sas
 Library:  Metadata
 Project:  NeighborhoodInfo DC
 Author:   P. Tatian
 Created:  04/29/14
 Version:  SAS 9.2
 Environment:  Local Windows session (desktop)
 
 Description:  Register libraries in metadata system.

 Modifications: 03/29/18 RP Update for DDOT and StanC Repos.
			    02/21/19 RP Add BLS 
                03/25/19 RP Add DCRA
                3/22/21 YS add RegAI
**************************************************************************/

%include "\\sas1\DCdata\SAS\Inc\StdLocal.sas";

** Define libraries **;
%DCData_lib( Metadata )

/*** USE THIS CODE TO DELETE A LIBRARY
%Delete_metadata_library(  
         ds_lib={libname},
         meta_lib=Metadata )
/***/


%DC_update_meta_library(
  lib_name=acip,
  lib_desc=Arts & Culture Indicators Project
)

%DC_update_meta_library(
  lib_name=acs,
  lib_desc=American Community Survey (ACS) summary files
)

%DC_update_meta_library(
  lib_name=ahs,
  lib_desc=American Housing Survey
)

%DC_update_meta_library(
  lib_name=Bainum,
  lib_desc=Bainum Family Foundation project
)

%DC_update_meta_library(
  lib_name=BLS,
  lib_desc=US Bureau of Labor Statistics
)

%DC_update_meta_library(
  lib_name=bpermits,
  lib_desc=Building permits
)

%DC_update_meta_library(
  lib_name=BridgePk,
  lib_desc=11th Street Bridge Park project
)

%DC_update_meta_library(
  lib_name=CDC500,
  lib_desc=CDC 500 Cities project
)

%DC_update_meta_library(
  lib_name=census,
  lib_desc=Decennial Census standard tabulations
)

%DC_update_meta_library(
  lib_name=CommFnd,
  lib_desc=Community Foundation/Brookings anti-poverty analysis
)

%DC_update_meta_library(
  lib_name=CoreLog,
  lib_desc=CoreLogic MarketTrends data
)

%DC_update_meta_library(
  lib_name=Covid19,
  lib_desc=Covid-19 response data and analysis
)

%DC_update_meta_library(
  lib_name=CPS,
  lib_desc=Current Population Survey
)

%DC_update_meta_library(
  lib_name=ctpp,
  lib_desc=Census Transportation Planning Package
)

%DC_update_meta_library(
  lib_name=dccash,
  lib_desc=DC CASH Campaign
)

%DC_update_meta_library(
  lib_name=dcola,
  lib_desc=%str(DC Mayor%'s Office on Latino Affairs)
)

%DC_update_meta_library(
  lib_name=dcra,
  lib_desc=%str(Department of Consumer and Regulatory Affairs)
)

%DC_update_meta_library(
  lib_name=ddot,
  lib_desc=%str(District Department of Transportation)
)

%DC_update_meta_library(
  lib_name=dhcd,
  lib_desc=DC Dept of Housing and Community Development
)


%DC_update_meta_library(
  lib_name=dmped,
  lib_desc=DC Deputy Mayor for Planning & Economic Development (DMPED)
)

%DC_update_meta_library(
  lib_name=DYouth,
  lib_desc=DC Disconnected Youth Study
)

%DC_update_meta_library(
  lib_name=Equity,
  lib_desc=DC Racial Equity Profile
)

%DC_update_meta_library(
  lib_name=Evict,
  lib_desc=Eviction data and analysis
)

%DC_update_meta_library(
  lib_name=FairHsng,
  lib_desc=DC Analysis of Impediments to Fair Housing 
)

%DC_update_meta_library(
  lib_name=fdic,
  lib_desc=Federal Deposit Insurance Corporation (locations of bank branches) 
)

%DC_update_meta_library(
  lib_name=general,
  lib_desc=General purpose data files
)

%DC_update_meta_library(
  lib_name=hand,
  lib_desc=HAND Housing Indicators Tool
)

%DC_update_meta_library(
  lib_name=hmda,
  lib_desc=Home Mortgage Disclosure Act (mortgage lending)
)

%DC_update_meta_library(
  lib_name=hsngmon,
  lib_desc=DC Housing Monitor Report
)

%DC_update_meta_library(
  lib_name=hsngsec,
  lib_desc=DC Region Housing Security Study
)

%DC_update_meta_library(
  lib_name=hud,
  lib_desc=%str(HUD assisted housing (public housing, project-based, vouchers, LIHTC))
)

%DC_update_meta_library(
  lib_name=ipums,
  lib_desc=Integrated Public Use Microdata Series (Census, ACS)
)

%DC_update_meta_library(
  lib_name=irs,
  lib_desc=%str(Internal Revenue Service (locations of tax preparers))
)

%DC_update_meta_library(
  lib_name=LEHD,
  lib_desc=%str(Longitudinal Employer Household Dynamics)
)

%DC_update_meta_library(
  lib_name=lps,
  lib_desc=LPS Analytics (regional mortgage loan performance)
)

%DC_update_meta_library(
  lib_name=mar,
  lib_desc=DC Master Address Repository (MAR)
)

%DC_update_meta_library(
  lib_name=mris,
  lib_desc=Metropolitan Regional Information Systems (regional real estate sales and listings)
)

%DC_update_meta_library(
  lib_name=nas,
  lib_desc=DC Neighborhood Assessment System (NAS)
)

%DC_update_meta_library(
  lib_name=ncdb,
  lib_desc=Neighborhood Change Database (NCDB)
)

%DC_update_meta_library(
  lib_name=nchsg,
  lib_desc=North Carolina Housing Assessment
)

%DC_update_meta_library(
  lib_name=nlihc,
  lib_desc=National Low Income Housing Coalition Preservation Catalog
)

%DC_update_meta_library(
  lib_name=nprofits,
  lib_desc=%str(Nonprofit organizations, National Center for Charitable Statistics (NCCS) database)
)

%DC_update_meta_library(
  lib_name=occ,
  lib_desc=Our Changing City web feature
)

%DC_update_meta_library(
  lib_name=octo,
  lib_desc=DC Office of the Chief Technology Officer
)

%DC_update_meta_library(
  lib_name=prescat,
  lib_desc=%str(DC Preservation Catalog)
)

%DC_update_meta_library(
  lib_name=pg,
  lib_desc=%str(Prince George%'s county data)
)

%DC_update_meta_library(
  lib_name=Planning,
  lib_desc=DC Office of Planning
)

%DC_update_meta_library(
  lib_name=police,
  lib_desc=%str(Crime reports, arrests, and 911 calls)
)

%DC_update_meta_library(
  lib_name=profiles,
  lib_desc=Neighborhood profiles
)

%DC_update_meta_library(
  lib_name=purple,
  lib_desc=Purple Line equitable development project
)

%DC_update_meta_library(
  lib_name=realprop,
  lib_desc=Real property data (property sales, real estate assessments and taxes, land use)
)


%DC_update_meta_library(
  lib_name=reghsg,
  lib_desc=%str(Regional Housing Framework)
)

%DC_update_meta_library(
  lib_name=requests,
  lib_desc=NeighborhoodInfo DC data requests
)

%DC_update_meta_library(
  lib_name=rod,
  lib_desc=%str(DC Recorder of Deeds (foreclosures, trustee sales))
)

%DC_update_meta_library(
  lib_name=schools,
  lib_desc=%str(Public, public charter, and private schools)
)

%DC_update_meta_library(
  lib_name=stanc,
  lib_desc=%str(The Commons at Stanton Square)
)

%DC_update_meta_library(
  lib_name=tanf,
  lib_desc=TANF and Food Stamp cases
)

%DC_update_meta_library(
  lib_name=vital,
  lib_desc=Vital statistics (births & deaths)
)

%DC_update_meta_library(
  lib_name=voices,
  lib_desc=VoicesDMV survey
)

%DC_update_meta_library(
  lib_name=voter,
  lib_desc=Voter registration and voting history
)

%DC_update_meta_library(
  lib_name=wawf,
  lib_desc=Washington Area Womens Foundation
)

%DC_update_meta_library(
  lib_name=RegAI,
  lib_desc=%str(Regional AI)
)

%DC_update_meta_library(
  lib_name=AmzHsg,
  lib_desc=%str(Amazon Housing Equity Fund)
)

%DC_update_meta_library(
  lib_name=HAND,
  lib_desc=%str(The Housing Association of Nonprofit Developers (HAND))
)


proc print data=metadata.meta_libs noobs label;
  title3 'Registered Libraries';

run;

