***Settings***
Documentation       Suite dos testes de cadastros

Library     SeleniumLibrary

Test Setup      Open Session
Test Teardown   Close Session

***Test Cases***
Cadastro simples
    Dado que acesso a pagina principal
    Quando submeto o email "joao@gmail.com"
    Então devo ser autenticado

***Keywords***
Dado que acesso a pagina principal
    Go To       http://ninjachef-qaninja-io.umbler.net/

Quando submeto o email "${email}"
    Input Text      id:email    ${email}
    Click Element   css:button[type=submit]
    sleep   3

Então devo ser autenticado
    Wait Until Page Contains Element    class:dashboard

## Hooks
Open Session
    Open Browser     about:blank     chrome

Close Session
    Close Browser