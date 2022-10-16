*** Settings ***
Documentation  Collection robot helper keywords

Library  SeleniumLibrary

*** Keywords ***
Open Tab
    [Arguments]    ${url}
    Execute Javascript   window.open('${url}');

Sign In With Credentials
    [Arguments]    ${usernameLocator}    ${passwordLocator}     ${loginButtonLocator}    ${username}    ${password}=${username}
    [Documentation]    Signs in to the given locators with the given credentials.
    Wait Until Element Is Visible   ${usernameLocator}
    Input Text    ${usernameLocator}    ${username}
    Input Text    ${passwordLocator}    ${password}
    Click Element   ${loginButtonLocator}

Click On Element
    [Arguments]  ${locator}
    [Documentation]    Clicks on element with the given locator after it is visible.
    Wait Until Element Is Visible  ${locator}
    Click Element  ${locator}

Type Text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    ${text}

Wait For Element By TestId
    [Arguments]    ${testid}
    Wait Until Element Is Visible    //*[@data-testid="${testid}"]

Click By TestId
    [Arguments]    ${testid}
    Wait For Element By TestId    ${testid}
    Click Element    //*[@data-testid="${testid}"]

Type By Test Id
    [Arguments]    ${testId}    ${text}
    Type Text     //*[@data-testid="${testid}"]      ${text}

Page Should Contain By TestId
    [Arguments]    ${testid}
    [Documentation]    This keyword checks if page contains element by TestId
    ${present}=    Run Keyword And Return Status    Page Should Contain Element    //*[@data-testid="${testid}"]
    [return]    ${present}
