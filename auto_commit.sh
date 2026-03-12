#!/usr/bin/env bash

# Caminho absoluto do repositório Git (hardcoded)
REPO_DIR="/caminho/para/o/teu/repo"

# Verifica se a pasta existe
if [ ! -d "$REPO_DIR" ]; then
  echo "Erro: a pasta '$REPO_DIR' não existe"
  exit 1
fi

# Muda para a pasta
cd "$REPO_DIR" || { echo "Falha ao entrar na pasta"; exit 1; }

# Verifica se é um repositório Git
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: '$REPO_DIR' não é um repositório Git"
  exit 1
fi

# Obter data e hora actual para o commit
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

# Adiciona todas as alterações
git add .

# Faz commit com data e hora no comentário
git commit -m "Auto commit em $timestamp"

# Faz push para o ramo remoto actual
current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$current_branch" ]; then
  git push origin "$current_branch"
fi

echo "Commit feito no repositório em $REPO_DIR com mensagem 'Auto commit em $timestamp'"
