*** Settings ***
Library    SeleniumLibrary
Documentation    Manual Invoice Requests 
Library           ExcelLibrary
Library           String
Library    Collections
Library       OperatingSystem

Resource    Common_Keyword.robot
  

*** Variables ***
${InvoiceWorkflow}        xpath://a[@href='/voucherstatusindex']



*** Keywords ***
Click On Manual Invoice Requests 
    Wait Until Element Is Visible   ${InvoiceWorkflow}
    Click Link   ${InvoiceWorkflow}  


    

