export ZSH="$HOME/.oh-my-zsh"

# THEME
ZSH_THEME="robbyrussell"

zstyle ':omz:update' frequency 7

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ---- DECOMPOSE CHAVE ACESSO ----#|

parse_dfe_key() {
    local chave="$1"

    if [[ ! $chave =~ ^[0-9]{44}$ ]]; then
        echo "Erro: A chave de acesso deve ter exatamente 44 dígitos numéricos."
        return 1
    fi

    local cUF="${chave:0:2}"
    local AAMM="${chave:2:4}"
    local CNPJ="${chave:6:14}"
    local mod="${chave:20:2}"
    local serie="$((10#${chave:22:3}))"
    local numDF="$((10#${chave:25:9}))"
    local tpEmis="${chave:34:1}"
    local cNF="${chave:35:8}"
    local cDV="${chave:43:1}"

    local doc_name="Desconhecido"
    case $mod in
        55) doc_name="NF-e" ;;
        57) doc_name="CT-e" ;;
        58) doc_name="MDF-e" ;;
        59) doc_name="CF-e" ;;
        63) doc_name="BP-e" ;;
        64) doc_name="GTV-e" ;;
        65) doc_name="NFC-e" ;;
        66) doc_name="NF3-e" ;;
        67) doc_name="CT-e OS" ;;
    esac

    echo "------------------------------"
    echo " Chave de Acesso - $doc_name "
    echo "------------------------------"
    echo "Código da UF:     $cUF"
    echo "Ano e Mês:        $AAMM"
    echo "CNPJ do Emitente: $CNPJ"
    echo "Modelo:           $mod - $doc_name"
    printf "Série:            %-3s\n" "$serie"
    printf "Número:           %-9s\n" "$numDF"
    echo "Forma de emissão: $tpEmis"
    echo "Código Numérico:  $cNF"
    echo "Dígito Verif.:    $cDV"
    echo "------------------------------"
}

#-------------ALIASES-------------#|
alias ag='antigravity'			  #|
#---------------------------------#|
alias gpl='git pull'              #|
alias gc='git checkout'           #|
alias gcs='git checkout staging'  #|
alias gcst='git checkout stable'  #|
alias gcb='git checkout -b'       #|
alias gcm='git commit -m'         #|
alias gaa='git add .'             #|
alias gml='git merge -'           #|
alias gstm='git stash -u -m'      #|
alias gsp='git stash -pop'        #|
alias gsl='git stash list'        #|
#---------------------------------#|
alias pi='pnpm install'           #|
alias ptb='pnpm tsc --build'      #|
alias pdev='pnpm run dev'         #|
#---------------END---------------#|

