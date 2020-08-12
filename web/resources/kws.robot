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

# KWS DO CENÁRIO RECEBER NOVO PEDIDO

Dado que ${email_cozinheiro} é a minha conta de cozinheiro
    Set Test Variable       ${email_cozinheiro}

    ${token_cozinheiro}=    Get Api token       ${email_cozinheiro}
    Set Test Variable       ${token_cozinheiro}


E ${email_cliente} é o email do meu cliente
    Set Test Variable    ${email_cliente}
    
    ${token_cliente}=    Get Api token           ${email_cliente}
    Set Test Variable    ${token_cliente}

E que ${produto} está cadastrados no meu dashboard

    Set Test Variable       ${produto}

    &{payload}=         Create Dictionary           name=${produto}    plate=Tipo      price=20.00
    ${image_file}=      Get Binary File             ${EXECDIR}/resources/images/produto.jpg
    &{files}=           Create Dictionary           thumbnail=${image_file}

    &{headers}=         Create Dictionary           user_id=${token_cozinheiro}

    Create Session    api               ${api_url} 
    ${resp}=          Post Request      api        /products    files=${files}       data=${payload}     headers=${headers}
    Status Should Be  200               ${resp}

    ${produto_id}           Convert To String     ${resp.json()['_id']}
    Set Test Variable       ${produto_id}

    Go To           ${base_url}

    Input Text      ${CAMPO_EMAIL}      ${email_cozinheiro}
    Click Element   ${BOTAO_ENTRAR}

    Wait Until Page Contains Element    ${DIV_DASH}
    sleep   3

Quando o cliente solicita o preparo desse prato

    &{headers}=      Create Dictionary           Content-Type=application/json      user_id=${token_cliente}
    &{payload}=      Create Dictionary           payment=dinheiro

    Create Session      api               ${api_url} 
    ${resp}=            Post Request      api        /products/${produto_id}/orders    data=${payload}     headers=${headers}
    Status Should Be    200               ${resp}
    Sleep               5

Então devo receber a notificação de pedido desse produto
    ${mensagem_esperada}        Convert To String       ${email_cliente} está solicitando o preparo do seguinte prato: ${produto}.
    Wait Until Page Contains    ${mensagem_esperada}    5

E posso aceitar ou rejeitar esse pedido
    Wait Until Page Contains    ACEITAR         5
    Wait Until Page Contains    REJEITAR        5