# References:
# - https://github.com/KevinNitroG/dotfiles/blob/main/home/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
# - https://github.com/ChrisTitusTech/powershell-profile/blob/main/Microsoft.PowerShell_profile.ps1

oh-my-posh init pwsh --config "C:\Users\mvoll\.config\powerlevel10k_lean.omp.json" | Invoke-Expression

# Zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd z powershell | Out-String) })
} else {
    Write-Host "zoxide command not found. Attempting to install via winget..."
    try {
        winget install -e --id ajeetdsouza.zoxide
        Write-Host "zoxide installed successfully. Initializing..."
        Invoke-Expression (& { (zoxide init --cmd z powershell | Out-String) })
    } catch {
        Write-Error "Failed to install zoxide. Error: $_"
    }
}

# Various

Set-Alias -Name halt -Value Stop-Computer
Set-Alias -Name reboot -Value Restart-Computer


function ll
{
    eza -la
}


if ((Get-Command -Name "eza" -ErrorAction SilentlyContinue))
{
  $DEFAULT_EZA_ARGS = @(
    "--colour=always",
    "--git",
    "--group-directories-first",
    "--icons=always",
    "--ignore-glob=.DS_Store",
    "--no-quotes",
    "--sort=type"
  )

  function _ls
  {
    eza -1 @DEFAULT_EZA_ARGS @args
  }

  function l
  {
    eza -l @DEFAULT_EZA_ARGS @args
  }

  function ll
  {
    eza -lag @DEFAULT_EZA_ARGS @args
  }

  function ld
  {
    eza -lD @DEFAULT_EZA_ARGS @args
  }

  function lt
  {
    eza --tree @DEFAULT_EZA_ARGS @args
  }

  function llt
  {
    eza --tree -lag @DEFAULT_EZA_ARGS @args
  }

  Set-Alias -Name ls -Value _ls -Force
}




function md5
{
  Get-FileHash -Algorithm MD5 $args
}
function sha1
{
  Get-FileHash -Algorithm SHA1 $args
}
function sha256
{
  Get-FileHash -Algorithm SHA256 $args
}

function head
{
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail
{
  param($Path, $n = 10)
  Get-Content $Path -Tail $n
}

function touch($file) { "" | Out-File $file -Encoding ASCII }

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

function export($name, $value) {
    set-item -force -path "env:$name" -value $value;
}

function df
{
    Get-Volume
}

function reloadprofile
{
    . $PROFILE
}

function pkill($name)
{
  Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name)
{
  Get-Process $name
}


# Git Shortcuts
function gst { git status }
function ga { git add }


# FZF
# FZF CONFIG

# Ref: https://github.com/catppuccin/powershell#profile-usage
# https://github.com/catppuccin/fzf - not use background for transparent
$env:FZF_DEFAULT_OPTS = @"
--color=hl:$($Flavor.Red),fg:$($Flavor.Text),header:$($Flavor.Red)
--color=info:$($Flavor.Mauve),pointer:$($Flavor.Rosewater),marker:$($Flavor.Rosewater)
--color=fg+:$($Flavor.Text),prompt:$($Flavor.Mauve),hl+:$($Flavor.Red)
--color=border:$($Flavor.Surface2)
--layout=reverse
--cycle
--scroll-off=5
--border
--preview-window=right,60%,border-left
--bind ctrl-u:preview-half-page-up
--bind ctrl-d:preview-half-page-down
--bind ctrl-f:preview-page-down
--bind ctrl-b:preview-page-up
--bind ctrl-g:preview-top
--bind ctrl-h:preview-bottom
--bind alt-w:toggle-preview-wrap
--bind ctrl-e:toggle-preview
"@

$commandOverride = [ScriptBlock] { param($Location) Write-Host $Location }

Set-PsFzfOption -AltCCommand $commandOverride

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PsFzfOption -PSReadlineChordProvider "Ctrl+e" -PSReadlineChordReverseHistory "Ctrl+r" -GitKeyBindings -TabExpansion -EnableAliasFuzzyGitStatus -EnableAliasFuzzyEdit -EnableAliasFuzzyFasd -EnableAliasFuzzyKillProcess -EnableAliasFuzzyScoop

function _fzf_open_path
{
  param (
    [Parameter(Mandatory = $false)]
    [string]$input_path
  )
  if (-not (Test-Path $input_path))
  {
    return
  }
  $cmds = @{
    'bat'    = { bat $input_path }
    'cat'    = { Get-Content $input_path }
    'cd'     = {
      if (Test-Path $input_path -PathType Leaf)
      {
        $input_path = Split-Path $input_path -Parent
      }
      Set-Location $input_path
    }
    'nvim'   = { nvim $input_path }
    'remove' = { Remove-Item -Recurse -Force $input_path }
    'echo'   = { Write-Output $input_path }
  }
  $cmd = $cmds.Keys | fzf --prompt 'Select command> '
  & $cmds[$cmd]
}

function _fzf_get_path_using_fd
{
  try
  {
    $input_path = fd --type file --follow --hidden --exclude .git |
      fzf --prompt 'Files> ' `
        --header-first `
        --header 'CTRL-S: Switch between Files/Directories' `
        --bind 'ctrl-s:transform:if not "%FZF_PROMPT%"=="Files> " (echo ^change-prompt^(Files^> ^)^+^reload^(fd --type file^)) else (echo ^change-prompt^(Directory^> ^)^+^reload^(fd --type directory^))' `
        --preview 'if "%FZF_PROMPT%"=="Files> " (bat --color=always {} --style=plain) else (eza -T --colour=always --icons=always {})'
    return $input_path
  } catch
  {
    return ""
  }
}

function _fzf_get_path_using_rg
{
  try
  {
    $INITIAL_QUERY = "${*:-}"
    $RG_PREFIX = "rg --column --line-number --no-heading --color=always --smart-case"
    $input_path = "" |
      fzf --ansi --disabled --query "$INITIAL_QUERY" `
        --bind "start:reload:$RG_PREFIX {q}" `
        --bind "change:reload:sleep 0.1 & $RG_PREFIX {q} || rem" `
        --bind 'ctrl-s:transform:if not "%FZF_PROMPT%" == "1. ripgrep> " (echo ^rebind^(change^)^+^change-prompt^(1. ripgrep^> ^)^+^disable-search^+^transform-query:echo ^{q^} ^> %TEMP%\rg-fzf-f ^& type %TEMP%\rg-fzf-r) else (echo ^unbind^(change^)^+^change-prompt^(2. fzf^> ^)^+^enable-search^+^transform-query:echo ^{q^} ^> %TEMP%\rg-fzf-r ^& type %TEMP%\rg-fzf-f)' `
        --color 'hl:-1:underline,hl+:-1:underline:reverse' `
        --delimiter ':' `
        --prompt '1. ripgrep> ' `
        --preview-label 'Preview' `
        --header 'CTRL-S: Switch between ripgrep/fzf' `
        --header-first `
        --preview 'bat --color=always {1} --highlight-line {2} --style=plain' `
        --preview-window 'up,60%,border-bottom,+{2}+3/3'
    $input_path = ($input_path -split ":")[0]
    return $input_path
  } catch
  {
    return ""
  }
}

function fdg
{
  _fzf_open_path $(_fzf_get_path_using_fd)
}

function rgg
{
  _fzf_open_path $(_fzf_get_path_using_rg)
}

Set-PSReadLineKeyHandler -Key "Ctrl+f" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("fdg")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Set-PSReadLineKeyHandler -Key "Ctrl+g" -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert("rgg")
  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
