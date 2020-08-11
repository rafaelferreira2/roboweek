***Settings***
Documentation       Aqui teremos todas as palavras chaves de automação de comportamentos

***Keywords***
Dado que acesso a pagina principal
    Go To       ${base_url}

Quando submeto o email "${email}"
    Input Text      ${CAMPO_EMAIL}     ${email}
    Click Element   ${BOTAO_ENTRAR}
    sleep   3

Então devo ser autenticado
    Wait Until Page Contains Element    ${DIV_DASH}

Então devo ver a mensagem "${expect_message}"
    Wait Until Element Contains     ${DIV_ALERT}     ${expect_message}

# Cadastro de pratos

Dado que "${produto}" é um dos meus pratos
    Set Test Variable       ${produto}

Quando faço o cadastro desse item
    Wait Until Element Is Visible       ${BTN_ADD}   5
    Click Element                       ${BTN_ADD}

    Choose File         ${CAMPO_IMG}    ${EXECDIR}/resources/images/${produto['img']}

    Input Text          ${CAMPO_NOME}          ${produto['nome']}
    Input Text          ${CAMPO_TIPO}          ${produto['tipo']}
    Input Text          ${CAMPO_PRECO}         ${produto['preco']}

    Click Element       ${BTN_CADASTRAR}

Então devo ver estre prato no meu dashboard
    Wait Until Element Contains     ${DIV_LISTA}     ${produto['nome']}