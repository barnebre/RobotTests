*** Settings ***
Library           Selenium2Library
Library           Framework/SauceLabs.py
Library           String
Library           Framework/Testing.py

*** Variables ***
@{_tmpFire}       name:Testing RobotFramework Selenium2Library,browserName:firefox, platform:Windows 8,version:14
@{_tmpIE}         name:Testing RobotFramework Selenium2Library,browserName:internet explorer, platform:Windows 8,version:10
${CAPABILITIES}    ${EMPTY.join(${_tmpIE})}
${LOGIN_FAIL_MSG}    Incorrect username or password.
${Browser}        firefox
${MobileApps}     http://testlpks.landpotential.org:8105/
${XpathLandHome}    //div[@class='scroll']/div[@class='row']/div[@class='col col-100 ']/img
${GoogleLoginBut}    loginGoogleWebBrowser
${GoogleSignIN}    Sign in - Google Accounts
${LandPKSSignIn}    LandPKS Sign-In
${GoogleEmailField}    Email
${GooglePassField}    Passwd
${GooglePassXpath}    //html/body/div/div[2]/div[2]/div[1]/form/div[2]/div/div[2]/div/div/input[2]
${GoogleSignINBut}    //html/body/div/div[2]/div[2]/div[1]/form/div[2]/div/input[1]
${GoogleApproveAccess}    submit_approve_access
${LandInfoIcon}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/div/div[1]/div[2]/img
${AddNewLandInfo}    //span[@class='right-buttons']/a[@class='button button-icon ion-plus-round']
${AddLandInfoPlotButton}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/a
${PlotNameIdLI}    name
${TestPlotYesRadioIdLI}    chkTestPlotYes
${OrgFieldIdLI}    organization
${LatFieldIdLI}    latitude
${LonFieldIdLI}    longitude
${BackButPlotCssLi}    body.grade-a.platform-browser.platform-win32.platform-ready ion-nav-bar.bar-stable.bar.bar-header.bar-balanced.nav-bar-container div.nav-bar-block ion-header-bar.bar-stable.bar.bar-header.bar-balanced.disable-user-behavior div.title.title-left.header-item span.nav-bar-title a.button.button-icon
${BackButPlotXpathLi}    //div[@nav-bar='active']/ion-header-bar/div[1]/span/a[2]
${LandInfoErrorMessage}    Answer to test plot is required.
${AlertPopUpCssLI}    body.grade-a.platform-browser.platform-win32.platform-ready.popup-open div.popup-container.remove-title-class.popup-showing.active div.popup div.popup-buttons button.button.ng-binding.button-positive
${ErrorMessageCssLI}    body.grade-a.platform-browser.platform-win32.platform-ready.popup-open div.popup-container.remove-title-class.popup-showing.active div.popup div.popup-body span
${AddPlotMenuPlotXpLI}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/a
${SubmitPlotButIdLI}    btnSubmitPlot_1
${SubmitPlotErrorButCssLI}    body.grade-a.platform-browser.platform-win32.platform-ready.popup-open div.popup-container.remove-title-class.popup-showing.active div.popup div.popup-buttons button.button.ng-binding.button-positive
${ReviewPlotXpLi}    //div[@class='scroll']/a[9]
${LandCoverXpLi}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/a[2]
${LinksAddPlot}    //div[@class='scroll']/a[@class='item item-icon-right othercomponent']
${FloodTypesXpsLI}    //div[@class='scroll']/div/div[contains(@class,'col col-5')]/img
${FloodTypesXpsLI1}    /html/body/ion-nav-view/ion-tabs/ion-nav-view/div/ion-view/ion-content/div/div/div[contains(@class,'col col-5')]/img
${SoilLayersXpsLI}    //div[@class='scroll']/a
${LatitudeInputID}    latitude
${LongitudeInputID}    longitude
${PopupButtonXpath}    //div[@class='popup-buttons']/button[@class='button ng-binding button-positive']
${PopupBodyXpath}    //div

*** Test Cases ***
Get Jenkins Driver
    [Tags]    Jenkins
    Set Selenium Timeout    15 seconds
    Set Selenium Speed    1.2 seconds
    ${JenkinsSetupSize}=    Get Browser Setup Count
    run keyword if    ${JenkinsSetupSize} >1    Mobile Multi Setup Jenks
    ...    ELSE    Mobile Setup Jenks

Google Login Jenkins
    ${ele}=    Run Keyword And Return Status    Element Should Not Be Visible    id=account-chooser-add-account
    Run keyword if    ${ele}    Handle New Google Login
    ...    ELSE    Handle Exisiting Account
    Select Window    ${LandPKSSignIn}

Add Plot Jenkins
    Add New Land Info Plot
    ${Sucess}=    Check for land info sucess
    run keyword if    ${Sucess}    Try to submit Land Info
    Check for land info sucess

Use main page to finish plot Jenkins
    [Documentation]    Uses Jenkins created browser to go through all aspects up site and check to make sure each performs well as expected. This can be run on local machine by setting the appropriate environmental variables
    mobile land info using main page
    Set Selenium Timeout    5 seconds
    [Teardown]    Close Test Browser

Check Mobile web
    [Tags]    Mobile
    Set Selenium Timeout    15 seconds
    Set Selenium Speed    .85 seconds
    Mobile Setup

Google Login
    [Tags]    Mobile
    ${ele}=    Run Keyword And Return Status    Element Should Not Be Visible    id=account-chooser-add-account
    Run keyword if    ${ele}    Handle New Google Login
    ...    ELSE    Handle Exisiting Account
    Select Window    ${LandPKSSignIn}

Add Plot
    [Tags]    Mobile
    Add New Land Info Plot
    ${Sucess}=    Check for land info sucess
    run keyword if    ${Sucess}    Try to submit Land Info
    Check for land info sucess

Use main page to finish plot
    [Tags]    Mobile
    mobile land info using main page
    Set Selenium Timeout    5 seconds

*** Keywords ***
Open test browser
    Open browser    http://www.google.com    ${Browser}    \    remote_url=${REMOTE_URL}    desired_capabilities=${CAPABILITIES}

Open test browser jenkins
    [Arguments]    ${Capa}    ${Remote}
    Open browser    http://www.google.com    ${Browser}    \    remote_url=${Remote}    desired_capabilities=${Capa}

Open test browser2
    [Arguments]    ${Capa}
    Open browser    http://www.google.com    ${Browser}    \    remote_url=${REMOTE_URL}    desired_capabilities=${Capa}

Close test browser
    Run keyword if    '${REMOTE_URL}' != ''    Report Sauce status    ${SUITE_NAME} | ${TEST_NAME}    ${TEST_STATUS}    ${TEST_TAGS}    ${REMOTE_URL}
    Close all browsers

Close test browser Jenkins
    [Arguments]    ${URL}    ${Name}    ${Status}
    Run keyword if    '${URL}' != ''    Report Sauce status    ${SUITE_NAME} | ${Name}    ${Status}    Jenkins    ${URL}
    Close all browsers

Mobile Setup
    Open test browser
    go to    ${MobileApps}
    Click element    xpath=${XpathLandHome}
    Click element    id=${GoogleLoginBut}

Mobile Multi Setup Jenks
    ${Creds}=    Get Sauce Creds Jenkins
    @{Browsers}=    Get Browsers
    : FOR    ${Browser}    IN    @{Browsers}
    \    ${caps}=    Set Jenkins Capabilities    ${Browser["browser"]}    ${Browser["platform"]}    ${Browser["version"]}
    \    Open test browser jenkins    ${caps}    ${Creds}
    \    ${Status}=    run keyword and return status    mobile manipulation
    \    ${PassOrFail}    set variable if    ${Status}    PASS    Fail
    \    Close Test Browser Jenkins    ${Creds}    ${Browser["browser"]}    ${PassOrFail}

Mobile Setup Jenks
    ${Caps}=    Get Jenkins Capabilities
    ${Creds}=    Get Sauce Creds Jenkins
    Open test browser jenkins    ${Caps}    ${Creds}
    mobile manipulation

Handle New Google Login
    Log    Detected Google account not stored adding new one
    @{GoogleCreds}=    Get Uname And Pword Lpks Gmail
    ${window}=    Run keyword and return status    Select window    Title=${GoogleSignIN}
    wait until page contains element    id=${GoogleEmailField}
    input text    id=${GoogleEmailField}    @{GoogleCreds}[0]
    Click Element    id=next
    wait until page contains element    id=${GooglePassField}
    focus    id=${GooglePassField}
    input text    id=${GooglePassField}    @{GoogleCreds}[1]
    Page should contain element    xpath=${GoogleSignINBut}
    Wait Until Element Is Enabled    xpath=${GoogleSignINBut}
    Wait Until Element Is visible    xpath=${GoogleSignINBut}
    Click element    ${GoogleSignINBut}
    Page should contain element    id=${GoogleApproveAccess}
    click element    id=${GoogleApproveAccess}

mobile manipulation
    go to    ${MobileApps}
    Wait Until Element Is Enabled    xpath=${XpathLandHome}
    Wait Until Element Is visible    xpath=${XpathLandHome}
    Click element    xpath=${XpathLandHome}
    Click element    id=${GoogleLoginBut}
    ${ele}=    Run Keyword And Return Status    Element Should Not Be Visible    id=account-chooser-add-account
    Run keyword if    ${ele}    Handle New Google Login
    ...    ELSE    Handle Exisiting Account
    Select Window    ${LandPKSSignIn}
    Add New Land Info Plot
    ${Sucess}=    Check for land info sucess
    run keyword if    ${Sucess}    Try to submit Land Info
    Check for land info sucess
    mobile land info using main page

mobile land info using main page
    log    Processing Main Page
    ${count}=    Get Matching Xpath Count    ${LinksAddPlot}
    @{Links}=    Get WebElements    xpath=${LinksAddPlot}
    : FOR    ${i}    IN RANGE    1    ${count} + 1
    \    ${link}=    Get WebElement    xpath=(${LinksAddPlot})[${i}]
    \    ${Atrib}=    get element atrrib    ${link}    href
    \    log    Processing Page | ${Atrib}
    \    click element if visable    ${link}
    \    run keyword if    '${Atrib}' == 'http://testlpks.landpotential.org:8105/#/landpks/landinfo_soillayers'    Exit for loop
    \    proc current module
    \    Try to submit Land Info
    \    Check for land info sucess
    proc soil layers
    Check for land info sucess
    submit Land Info

proc soil layers
    log    Processing Soil Layers
    ${count}=    Get Matching Xpath Count    ${SoilLayersXpsLI}
    : FOR    ${i}    IN RANGE    1    ${count} + 1
    \    ${link}=    Get WebElement    xpath=(${SoilLayersXpsLI})[${i}]
    \    ${Vis}=    click element if visable    ${link}
    \    run keyword if    ${Vis}    proc soil layer

proc soil layer
    log    Processing Individual Soil Layer
    click button    xpath=//div[@nav-view='active']/ion-view[@cache-view='false']/ion-scroll/div[@class='scroll']/div[2]/button
    wait until page contains element    id=radioBall
    @{Elements}=    Get Webelements    tag=input
    : FOR    ${element}    IN    @{Elements}
    \    ${text}=    Get Value    ${element}
    \    run keyword unless    '${text}' == 'NO'    click element if visable    ${element}
    \    Scroll To Element    ${element}
    ${Submit}=    get web element    xpath=//div[@id='btnSelect']/button
    click element if visable    ${Submit}
    ${layer}=    Get WebElement    xpath=//div[@class='lpks-select']/input
    Click element if visable    ${layer}
    ${randomIndex}    Generate Random String    1    1234
    click element    xpath=/html/body/div[4]/div/div[2]/div/ion-view/ion-content/div[1]/a[${randomIndex}]/img
    log    go back
    click element if visable by locator    xpath=/html/body/ion-nav-bar/div[2]/ion-header-bar/div[1]/span/a[2]

proc current module
    @{FloodTypes}=    Get WebElements    xpath=${FloodTypesXpsLI}
    : FOR    ${FloodType}    IN    @{FloodTypes}
    \    ${Atrib}=    get element atrrib    ${FloodType}    class
    \    click element if visable    ${FloodType}
    Check for land info sucess

click element if visable
    [Arguments]    ${element}
    ${Visible}    run keyword and return status    element should be visible    ${element}
    run keyword if    ${Visible}    click element    ${element}
    [Return]    ${Visible}

click element if visable by locator
    [Arguments]    ${locate}
    ${element}=    get webelement    ${locate}
    ${Visible}    run keyword and return status    element should be visible    ${element}
    run keyword if    ${Visible}    click element    ${element}
    [Return]    ${Visible}

submit Land Info
    Click link    xpath=${ReviewPlotXpLi}
    Click element    id=${SubmitPlotButIdLI}
    ${success}=    Run keyword and return status    Element Should Contain    xpath=//div[@class='popup-body']/span[1]    Confirm submit. Submitted data may become publicly available.
    run keyword if    '${success}'=='False'    Proc Error on Submit
    ${result}=    Run keyword and return status    element should be visible    xpath=//div[@class='popup-buttons']/button[@class='button ng-binding button-positive']
    run keyword if    ${result}    click element    xpath=//div[@class='popup-buttons']/button[@class='button ng-binding button-positive']
    wait until element is visible    xpath=//div[@class='popup-body']/span[1]
    ${success}=    Run keyword and return status    Element Should Contain    xpath=//div[@class='popup-body']/span[1]    Plot is submitted
    run keyword if    ${success}    element should be visible    xpath=//div[@class='popup-buttons']/button[@class='button ng-binding button-positive']
    run keyword if    ${success}    click element    xpath=//div[@class='popup-buttons']/button[@class='button ng-binding button-positive']
    run keyword unless    ${success}    Proc Error on Submit
    [Return]    ${success}

Proc error on submit
    ${PopupBody}=    set variable    //div[@class='popup-body']/span
    ${count}=    Get Matching Xpath Count    ${PopupBody}
    : FOR    ${i}    IN RANGE    1    ${count} + 1
    \    ${error}=    Get WebElement    xpath=(${PopupBody})[${i}]
    \    ${Text}=    get text    ${error}
    \    ${Lat}=    run keyword and return status    should contain    ${Text}    Latitude
    \    ${Long}=    run keyword and return status    should contain    ${Text}    Longitude
    \    run keyword if    ${Long}    Long error found
    \    run keyword if    ${Lat}    Long error found

Long Error Found
    click element    xpath=//div[@class='popup-buttons']/button[@class='button ng-binding button-positive']
    Proc Lat and Long Error
    exit for loop
    proc error on submit

Proc Lat and Long Error
    click element    xpath=${BackButPlotXpathLi}
    Wait Until Element Is visible    xpath=//div[@nav-view='active']/ion-view/ion-content/div/a[1]
    click element    xpath=//div[@nav-view='active']/ion-view/ion-content/div/a[1]
    ${RandLat}=    Generate Random String    2    123456789
    input text    id=${LatitudeInputID}    ${RandLat}
    ${RandLong}=    Generate Random String    2    123456789
    input text    id=${LongitudeInputID}    ${RandLong}
    Check for land info sucess
    Click link    xpath=${ReviewPlotXpLi}
    Click element    id=${SubmitPlotButIdLI}

Try to submit Land Info
    Click link    xpath=${ReviewPlotXpLi}
    Click element    id=${SubmitPlotButIdLI}
    ${result}=    Run keyword and return status    element should be visible    xpath=${PopupButtonXpath}
    element should contain    xpath=/html/body/div[4]/div/div[@class='popup-body']/span[1]    The following are required
    run keyword if    ${result}    click element    xpath=${PopupButtonXpath}
    [Return]    ${result}

Add New Land Info Plot
    Wait Until Element Is visible    xpath=${LandInfoIcon}
    Click element    xpath=${LandInfoIcon}
    : FOR    ${I}    IN RANGE    1    10
    \    ${TextThere}=    run keyword and return status    Page should not contain element    xpath=//div[@class='loading-container']/div[@class='loading']/span
    \    run keyword if    ${TextThere}    Exit for Loop
    \    BuiltIn.Sleep    1s
    Wait until element is enabled    xpath=//div[@class='list']
    Wait Until Element Is enabled    xpath=${AddNewLandInfo}
    ${Clicked}=    run keyword and return status    click element    xpath=${AddNewLandInfo}
    run keyword unless    ${Clicked}    click element    xpath=${AddNewLandInfo}
    Wait Until Element Is visible    xpath=${AddPlotMenuPlotXpLI}
    click element    xpath=${AddPlotMenuPlotXpLI}
    Set Selenium Speed    .35 seconds
    Check for land info error
    click element    id=${TestPlotYesRadioIdLI}
    ${RandLength}=    Generate Random String    1    123456789
    ${RandomString}=    Generate Random String    ${RandLength}
    @{Elements}=    Get Webelements    tag=input
    : FOR    ${element}    IN    @{Elements}
    \    ${text}=    Get Value    ${element}
    \    run keyword unless    '${text}' == 'small' or '${text}' =='medium'    input text    ${element}    ${RandomString}
    Element should not contain    id=${LongitudeInputID}    ${RandomString}
    click element    id=btnObtainGPS
    ${GPSError}=    Run keyword and return status    Element Should Contain    xpath=//div[@class='popup-body']/span[1]    Geolocation
    run keyword if    ${GPSError}    click element    xpath=//div[@class='popup-buttons']/button[@class='button ng-binding button-positive']

Check for land info sucess
    wait until page contains element    xpath=${BackButPlotXpathLi}
    Click link    xpath=${BackButPlotXpathLi}
    ${result}=    Run keyword and return status    page should not contain element    xpath=${PopupButtonXpath}
    [Return]    ${result}

Check for land info error
    wait until page contains element    xpath=${BackButPlotXpathLi}
    Click link    xpath=${BackButPlotXpathLi}
    page should contain element    xpath=${PopupButtonXpath}
    click element    xpath=${PopupButtonXpath}

Handle Exisiting Account
    ${idForAccount}=    get correct account    GoogleEmail
    Page should contain element    id=${idForAccount}
