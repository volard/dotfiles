# super naive simple check on neovim command alias to determine if pwsh config already is working
if (Test-Path alias:v) { }
else {
  # Make sure I'll able to read command line helps instead 
  # of Medium in free time
  sudo update-help;

  # ---------------------------
  # Install modules
  # ---------------------------
  Install-Module PSReadLine     -Scope CurrentUser -force;
  Install-Module Terminal-Icons -Scope CurrentUser -force;
  Install-Module PSFzf          -Scope CurrentUser -force;
  Install-Module Recycle        -Scope CurrentUser -force;

  $profile.CurrentUserCurrentHost;

  # If u've changed documents destination u got the idea of this overengineering
  ni -path  $([Environment]::getfolderpath('MyDocuments') + '\PowerShell\Microsoft.PowerShell_profile.ps1') -itemtype file -force;

  $profile.CurrentUserCurrentHost;

  ". $env:userprofile\.config\powershell\profile.ps1" > $([Environment]::getfolderpath('MyDocuments') + '\PowerShell\Microsoft.PowerShell_profile.ps1');
}

