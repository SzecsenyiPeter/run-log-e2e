*** Settings ***
Documentation   Codesk e2e test cases

Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

Resource    general.robot

*** Variables ***
${BROWSER}    chrome
${URL}     http://localhost:3000
${ATHLETE_NAME}    robot-athlete-2
${COACH_NAME}    robot-coach-2


*** Test Cases ***

Register Coach And Athlete

    Setup

    Register     ${COACH_NAME}     Coach
    Register     ${ATHLETE_NAME}     Athlete

    Close All Browsers

Check Coach Features
    Setup

    Login     ${COACH_NAME}
    Add Athlete
    Create Run Plan

    Close All Browsers
Check Athlete Features
    Setup

    Login     ${ATHLETE_NAME}
    Create Run
    Check And Link Run

    Close All Browsers

*** Keywords ***
Login
    [Arguments]    ${username}
    Click By TestId      menu-login

    Type By Test Id      login-username     ${username}
    Type By Test Id      login-password     ${username}

    Click By TestId      login-submit

Register
    [Arguments]    ${username}     ${type}
    Click By TestId      menu-register

    Type By Test Id      register-username     ${username}
    Type By Test Id      register-password     ${username}
    Type Text      //*[@aria-autocomplete="list"]     ${type}
    Click Element       //label[contains(text(),'Username')]

    Click By TestId      register-submit

    Sleep      1 seconds

Add Athlete
    Click By TestId     menu-list

    Click By TestId     add-athlete-open

    Type Text      //*[@list="athletes"]      ${ATHLETE_NAME}

    Click By TestId     add-athlete-confirm

    Sleep      2 seconds

Create Run Plan
    Click By TestId     menu-create-run-plan

    Type By Test Id      run-plan-instructions     INSTRUCTIONS
    Type By Test Id      run-plan-distance     10
    Type By Test Id      run-plan-heartrate     160
    Type By Test Id      run-plan-minutes     4
    Type By Test Id      run-plan-seconds     30

    Type By Test Id      input     ${ATHLETE_NAME}
    Press Keys      //*[@data-testid="input"]      ENTER

    Click By TestId      run-plan-submit

    Sleep      2 seconds

Create Run
    Click By TestId     menu-add

    Type By Test Id      run-form-title     TITLE
    Type By Test Id      run-form-description     DESCRIPTION
    Type By Test Id      run-form-hour     0
    Type By Test Id      run-form-minute     47
    Type By Test Id      run-form-second     45
    Type By Test Id      run-form-distance     10
    Type By Test Id      run-form-heartrate     160

    Click By TestId      run-form-submit

    Sleep      2 seconds

Check And Link Run
    Click By TestId     menu-list

    Wait Until Page Contains     TITLE
    Click Element       //td[contains(text(),'TITLE')]

    Wait Until Page Contains     DESCRIPTION

    Click By TestId      link-plan-open
    Sleep      1 seconds

    Click By TestId      link-plan-confirm
    Sleep      2 seconds

    Reload Page

    Login     ${ATHLETE_NAME}

    Wait Until Page Contains     INSTRUCTIONS

Setup
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    15 seconds
