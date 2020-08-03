***Settings***
Documentation       Aqui teremos todas as palavras chaves de automação de comportamentos

***Keywords***
Dado que acesso a pagina principal
    Go To       http://ninjachef-qaninja-io.umbler.net/

Quando submeto o email "${email}"
    Input Text      id:email    ${email}
    Click Element   css:button[type=submit]
    sleep   3

Então devo ser autenticado
    Wait Until Page Contains Element    class:dashboard

Então devo ver a mensagem "${expect_message}"
    Wait Until Element Contains     class:alert     ${expect_message}