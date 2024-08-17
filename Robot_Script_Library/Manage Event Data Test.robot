*** Settings ***
Library    SeleniumLibrary
Documentation    Manual Invoice Requests 
Resource    ../Robot_Custom_Library/Common_Keyword.robot
Resource    ../Robot_Custom_Library/Manage Event Data page.robot


*** Test Cases ***
TC001
    TC001K_Login_In_Enabill_4.5 with valid Credentials
    Serach    Manage Event Data
    Manage Event Data
    
    
