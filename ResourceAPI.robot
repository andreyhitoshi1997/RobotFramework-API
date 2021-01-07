*** Settings ***
Documentation         Documentação da API: https://fakerestapi.azurewebsites.net/api
Library               RequestsLibrary
Library               Collections

*** Variable ***
${URL_API}      https://fakerestapi.azurewebsites.net/api/v1
&{ACTIVITY_15}      id=15
...                 title=Activity 15
...                 completed=False


*** Keywords ***
#SETUP E TEARDOWNS
Conectar a minha API
    Create Session      fakeAPI     ${URL_API}    

#Ações
Requisitar todos os atividades
    ${RESPOSTA}     Get Request      fakeAPI    Activities   
    Log             ${RESPOSTA.text} 
    Set Test Variable       ${RESPOSTA}

Requistiar a atividade "${ID_ACTIVITIES}"
    ${RESPOSTA}     Get Request      fakeAPI    Activities/${ID_ACTIVITIES} 
    Log             ${RESPOSTA.text} 
    Set Test Variable       ${RESPOSTA}

Cadastrar um nova atividade
    ${HEADERS}      Create Dictionary        content-type=application/json
    ${RESPOSTA}     Post Request      fakeAPI    Activities 
    ...                               data={"id": 2323,"title": "teste","dueDate": "2021-01-07T15:35:22.956Z", "completed": true}
    ...                               headers=${HEADERS} 
    Log             ${RESPOSTA.text} 
    Set Test Variable       ${RESPOSTA}
### COnferências
Conferir o status code
    [Arguments]     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.status_code}        ${STATUSCODE_DESEJADO}

Conferir o reason 
    [Arguments]     ${REASON_DESEJADO}
    Should Be Equal As Strings          ${RESPOSTA.reason}         ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" atividades
    Length Should Be        ${RESPOSTA.json()}         ${QTDE_LIVROS}

Conferir se retorna todos os dados a atividade 15
    Dictionary Should Contain Item      ${RESPOSTA.json()}       id                     ${ACTIVITY_15.id}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       title                  ${ACTIVITY_15.title}
    Dictionary Should Contain Item      ${RESPOSTA.json()}       completed              ${ACTIVITY_15.completed}