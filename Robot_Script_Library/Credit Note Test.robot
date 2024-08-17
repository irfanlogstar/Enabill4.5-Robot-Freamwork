*** Settings ***
Library    SeleniumLibrary
Documentation    Manual Invoice Requests 
Resource    ../Robot_Custom_Library/Common_Keyword.robot
Resource    ../Robot_Custom_Library/Credit Note Page.robot

*** Variables ***
${AddDrescrption}    Test
${Unit}    2
${Rate}    100
${CusName}    7 STAR LOGISTICS

*** Test Cases ***
TC001
    TC001K_Login_In_Enabill_4.5 with valid Credentials
    Serach    Credit
    Click On Credit/Debit Note
    
    
TC002   
    Add The Mandatory Fields    ${CusName}
    
TC003
    Add Charge    ${AddDrescrption}     ${Unit}    ${Rate}
    Submit Debit Note
    