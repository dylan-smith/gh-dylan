$AssemblyVersion = "0.0"

if ((Test-Path env:CLI_VERSION) -And $env:CLI_VERSION.StartsWith("refs/tags/v"))
{
    $AssemblyVersion = $env:CLI_VERSION.Substring(11)
}

Write-Output "version: $AssemblyVersion"

### gei ###
dotnet publish src/gh-dylan/gh-dylan.csproj -c Release -o dist/win-x64/ -r win-x64 -p:PublishSingleFile=true -p:PublishTrimmed=true --self-contained true /p:DebugType=None /p:IncludeNativeLibrariesForSelfExtract=true /p:VersionPrefix=$AssemblyVersion

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

dotnet publish src/gh-dylan/gh-dylan.csproj -c Release -o dist/linux-x64/ -r linux-x64 -p:PublishSingleFile=true -p:PublishTrimmed=true --self-contained true /p:DebugType=None /p:IncludeNativeLibrariesForSelfExtract=true /p:VersionPrefix=$AssemblyVersion

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

dotnet publish src/gh-dylan/gh-dylan.csproj -c Release -o dist/osx-x64/ -r osx-x64 -p:PublishSingleFile=true -p:PublishTrimmed=true --self-contained true /p:DebugType=None /p:IncludeNativeLibrariesForSelfExtract=true /p:VersionPrefix=$AssemblyVersion

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Rename-Item ./dist/win-x64/gh-dylan.exe dylan-windows-amd64.exe
Rename-Item ./dist/linux-x64/gh-dylan dylan-linux-amd64
Rename-Item ./dist/osx-x64/gh-dylan dylan-darwin-amd64