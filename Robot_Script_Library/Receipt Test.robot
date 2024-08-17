*** Settings ***
Library    SeleniumLibrary
Resource    ../Robot_Custom_Library/Common_Keyword.robot
Resource    ../Robot_Custom_Library/Receipt Page.robot


*** Variables ***
${Customer Name}        KHAR TECHNOLOGIES PRIVATE LIMITED
${EnterSlipNo}        1234
${EnterREAMT}    100
${EnterRemark}    Test
${SettlementAmount}    50




*** Test Cases ***
Tc001
      [Documentation]    Check if the user can create an invoice for the provided booking.
    ...    - User searches for "Manual Invoice Requests" and navigates to the page.   
         
    TC001K_Login_In_Enabill_4.5 with valid Credentials
    Serach    Receipt
    Navigate to Receipt screen
    
# TC002
    # [Documentation]    Enter All Mandatory Filed of receipt
     # Enter Receipt Details    ${Customer Name}
     # Sleep    5s
     
# TC003
    # Type Of Receipt Normal
    # Enter Receipt Amount    ${EnterSlipNo}    ${EnterREAMT}    ${EnterRemark}        

# TC004
        # Get Receipt Data
# Tc005
    # Open Receipt
    
TC006
    Partila Settlement    ${Customer Name}    ${EnterSlipNo}    ${EnterREAMT}    ${EnterRemark}    ${SettlementAmount}
    
    