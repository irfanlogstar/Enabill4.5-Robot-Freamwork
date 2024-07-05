*** Settings ***
Library    ExcelLibrary
Library    SeleniumLibrary
Resource    ../Robot_Custom_Library/Common_Keyword.robot
    
*** Variables ***
${SiteURL}     http://172.16.23.54:9009/login
${Browser}    chrome
${FilePath}   ${CURDIR}${/}..\\Robot_Data_Library\\Data.xlsx
${SheetName}     Login

*** Keywords ***
TC001K_Login_In_Enabill_4.5 with valid Credentials
    [Documentation]   TO want to verify if the system allows a user to log into the Enabill system using a valid username and password.
    Open My Browser    ${SiteURL}    ${Browser}
    ${UserName}=    Read Excel    ${FilePath}    ${SheetName}    2    1
    ${Password}=    Read Excel    ${FilePath}    ${SheetName}    2    2
    Login With Credentials      ${UserName}    ${Password}
    Disaply The Enabill Logo

*** Test Cases ***

TC001_Login_In_Enabill_4.5 with valid Credentials
    [Documentation]   TO want to verify if the system allows a user to log into the Enabill system using a valid username and password.
    Open My Browser    ${SiteURL}    ${Browser}
    ${UserName}=    Read Excel    ${FilePath}    ${SheetName}    2    1
    ${Password}=    Read Excel    ${FilePath}    ${SheetName}    2    2
    Login With Credentials      ${UserName}    ${Password}
    Disaply The Enabill Logo
    
TC002_Login_In_Enabill_4.5 with Invalid Credentials
     [Documentation]   TO want to verify if the system allows a user to log into the Enabill system using a Invalid username and password.
    Open My Browser    ${SiteURL}    ${Browser}
    ${UserName}=    Read Excel    ${FilePath}    ${SheetName}    3    1
    ${Password}=    Read Excel    ${FilePath}    ${SheetName}    3    2
    Login With Credentials      ${UserName}    ${Password}
    Display Invalid User
    
TC003
    TC001K_Login_In_Enabill_4.5 with valid Credentials
    
    

