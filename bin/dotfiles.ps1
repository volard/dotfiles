# ---------------------------
# Install WSL
# ---------------------------
# https://docs.microsoft.com/ru-ru/windows/wsl/install-manual
# Admin rights required

try {
    wsl --help
    Write-Host "WSL is installed."

    # set a second version as a default
    wsl --set-default-version 2;

    # install distro
    wsl --install -d Ubuntu;

    wsl --set-default Ubuntu

} catch {
    Write-Host "WSL is not installed."

    # enable windows feature
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

    # enable WSL
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart;

    # launch virtual platform or something
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart;

    # enable hyper-v
    dism.exe /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V

    # download and launch wsl installer
    iwr https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -outfile wsl_update_x64.msi;
    .\wsl_update_x64.msi;

    Read-Host "Press any key (except power/restart button) to continue..."
    exit
}


$command = "bash -c '$(curl -fsSL https://gitlab.com/dotfiles30/comma_files/-/raw/main/bin/dotfiles.sh)'"

wsl $command
