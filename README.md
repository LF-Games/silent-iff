# Silent IFF

Jogo de suspense/visual novel feito em Godot, sobre um aluno explorando um cenário surrealista de uma universidade, enquanto constroi/descobre sua personalidade.

## Links importantes

- [GDD](https://docs.google.com/document/d/1yuRJMmNVyQuoWwwmEBEvvDJNAoMVxQ_VIXf1g037q5Q/edit?usp=sharing)
- [Godot](https://godotengine.org/) (Game Engine)
- [Dialogic](https://docs.dialogic.pro/) (Plugin utilizado para diálogos)

## Guia de colaboração

Sempre que iniciar uma nova tarefa, crie uma nova branch a partir da ``main``
```bash
git checkout main
git pull # Garante que está usando a versão mais atual do código
git checkout -b minha-tarefa 
```

Utilize mensagens curtas e descritivas em todos os commits. De preferência, utilize prefixos como "fix:" ou "feat:" para indicar o tipo de mudança, como sugere a [Conventional Commits](https://www.conventionalcommits.org/pt-br/v1.0.0/). Exemplos:
- ``fix: bug ao trocar de mapa`` ("fix" para correção de bugs)
- ``feat: movimentação do personagem`` ("feat" para novas funcionalidades)
- ``chore: corrige formatação`` ("chore" pode ser usado para tarefas de organização, formatação, configuração, etc)

Quando uma tarefa for finalizada, [crie um Pull Request](https://docs.github.com/pt/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) e [solicite uma revisão](https://docs.github.com/pt/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/requesting-a-pull-request-review).

## Padronização do código

Sempre que possível, siga as orientações descritas no [Guia de Estilo GDScript](https://docs.godotengine.org/pt-br/4.x/tutorials/scripting/gdscript/gdscript_styleguide.html), para que o código seja fácil de entender para todos no projeto.
