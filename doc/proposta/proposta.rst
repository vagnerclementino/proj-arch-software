
****************************************************************************************
Proposta de Trabalho: Ferramenta Semi-Automática para Análise de Violações Arquiteturais
****************************************************************************************

:Date: 2016-03-28 21:51:47
:Author: Vagner Clementino
:Revision: 1
:Revision Date: 2016-03-28 21:51:47

Objetivo
========

  - Desenvolver uma ferramenta semi-automatizada que possibilite ao desenvolvedor avaliar o impacto de uma mudança na arquitetura do sistema que está sendo mantido.

Contexto / Problema / Solução / Avaliação (`COMPROSA`_)
--------------------------------------------------------

Contexto
^^^^^^^^

  - "Software aging is like milk, not like wine."
  - Mudança em software são inevitáveis.
  - Mudanças podem afetar a arquitetura do software, causando, desvios arquiteturais
  - Tais desvios, em conjunto, podem causar uma "Erosão Arquitetural"

Problema
^^^^^^^^
  - Diversas soluções vem sendo propostas para analisar o código fonte em busca de desvios arquiteturais

    + Dependency-Structure Matrices
    + Source Code Query Languages
    + Reflexion Models

  - Este tipo de solução trata o problema após ele já ter ocorrido.

Solução
^^^^^^^
  - Seria interessante se os desenvolvedores entendesse melhor o efeito de uma mudança antes de realizá-la efetivamente.
  - Em especial, seria relevante o desenvolvedor avaliar o impacto na arquitetura que determinadas mudanças irão causar.
  - Para este fim é proposto uma ferramenta semi-automatizada capaz de avaliar o impacto que uma mudança pode causar na arquitetura do sistema

    + Para este fim, a ferramenta recebe dois arquivos:

      * O primeiro contêm a arquitetura do sistema modelada através de um conjunto de regras
      * O segundo contêm a mudança a ser realizada modelada em conjunto de diretiavas

    + Com base neste dois arquivos a ferramenta é capaz de informar se a mudança proposta irá causar algum desvio arquitetural.

Avaliação
^^^^^^^^^

  - A ferramenta pode ser avaliada mediante um experimento controlado onde serão propostas atividades de manutenção de software para dois grupos distintos. O primeiro grupo irá realizar as atividades de manutenção sem a ajuda da ferramenta. Em contrapartida, o segundo grupo deverá realizar o mesmo conjunto de atividades tendo como suporte a ferramenta proposta. Espera-se que no grupo onde houve o suporte da ferramenta o número de desvios arquiteturais seja menor do que no outro grupo.


Population / Intervention / Comparation / Output (`PICO`_)
------------------------------------------------------------

Population
^^^^^^^^^^

  - Desenvolvedores realizando tarefas de manutenção de software.

Intervetion
^^^^^^^^^^^

  - Realização das atividades de manutenção de software *com* suporte da ferramente ora proposta.

Comparation
^^^^^^^^^^^

  - Realização das atividades de manutenção de software *sem* suporte da

Output
^^^^^^

  - No grupo de desenvolvedores que utilizarem o suporte da ferramenta proposta o número de desvios arquiteturais será menor do que no grupo que *não* utilizou a ferramenta.

.. _COMPROSA: http://homepages.dcc.ufmg.br/~mirella/ppt/SeminarioRumo.2015.pdf
.. _PICO: https://en.wikipedia.org/wiki/PICO_process