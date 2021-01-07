*** Settings ***
Documentation Documentação da API: https://fakerestapi.azurewebsites.net/api/v1/Activities
Resource        ResourceAPI.robot
Suite Setup     Conectar a minha API

*** Test Case ***
Buscar a listagem de todos os atividades (GET em todos os atividades)
    Requisitar todos os atividades
    Conferir o status code      200
    Conferir o reason           OK
    Conferir se retorna uma lista com "30" atividades

Buscar um livro específico (GET em um livro específico)
    Requistiar a atividade "15"
    Conferir o status code      200
    Conferir o reason           OK
    Conferir se retorna todos os dados a atividade 15

Cadastrar um nova atividade(POST)
    Cadastrar um nova atividade