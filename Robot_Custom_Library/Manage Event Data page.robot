*** Settings ***
Library    SeleniumLibrary
Documentation    Manual Invoice Requests 
Resource    Common_Keyword.robot

*** Variables ***
${Manual Invoice Requests}     //a[@href='/eventdataindex']
${STATUS_DROPDOWN}  //kendo-dropdownlist[contains(@class, 'k-picker-md') and @textfield='Name' and @valuefield='Code']
${STATUS_OPTION}  //li[text()='Error']
${FILTER_BUTTON}     //button[@class='btn btn-Enabill']//i[@class='fa fa-filter']

*** Keywords ***
Manage Event Data
    Click Link    ${Manual Invoice Requests} 
    Wait Until Element Is Visible  ${STATUS_DROPDOWN}  10s
    Click Element  ${STATUS_DROPDOWN}
     Wait Until Element Is Visible  ${STATUS_OPTION}  10s
     Click Element  ${STATUS_OPTION}   
     Click Button    ${FILTER_BUTTON} 
     

    