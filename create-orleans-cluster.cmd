@REM Create Orleans cluster projects and solution.

dotnet new sln
mkdir -p src\OrleansSilo
mkdir -p src\OrleansClient
mkdir -p src\OrleansGrains
mkdir -p src\OrleansGrainInterfaces
dotnet new console -o src\OrleansSilo --framework netcoreapp2.0
dotnet new console -o src\OrleansClient --framework netcoreapp2.0
dotnet new classlib -o src\OrleansGrains --framework netstandard2.0
dotnet new classlib -o src\OrleansGrainInterfaces --framework netstandard2.0
dotnet sln add src\OrleansSilo\OrleansSilo.csproj
dotnet sln add src\OrleansClient\OrleansClient.csproj
dotnet sln add src\OrleansGrains\OrleansGrains.csproj
dotnet sln add src\OrleansGrainInterfaces\OrleansGrainInterfaces.csproj
dotnet add src\OrleansClient\OrleansClient.csproj reference src\OrleansGrainInterfaces\OrleansGrainInterfaces.csproj
dotnet add src\OrleansSilo\OrleansSilo.csproj reference src\OrleansGrainInterfaces\OrleansGrainInterfaces.csproj
dotnet add src\OrleansGrains\OrleansGrains.csproj reference src\OrleansGrainInterfaces\OrleansGrainInterfaces.csproj
dotnet add src\OrleansSilo\OrleansSilo.csproj reference src\OrleansGrains\OrleansGrains.csproj

set ORLEANS_VER=2.0.3

dotnet add src\OrleansClient\OrleansClient.csproj package Microsoft.Orleans.Core --version %ORLEANS_VER%
dotnet add src\OrleansClient\OrleansClient.csproj package Microsoft.Orleans.Client --version %ORLEANS_VER%

dotnet add src\OrleansGrainInterfaces\OrleansGrainInterfaces.csproj package Microsoft.Orleans.Core --version %ORLEANS_VER%
dotnet add src\OrleansGrainInterfaces\OrleansGrainInterfaces.csproj package Microsoft.Orleans.OrleansCodeGenerator.Build --version %ORLEANS_VER%

dotnet add src\OrleansGrains\OrleansGrains.csproj package Microsoft.Orleans.Core --version %ORLEANS_VER%
dotnet add src\OrleansGrains\OrleansGrains.csproj package Microsoft.Orleans.OrleansCodeGenerator.Build --version %ORLEANS_VER%

dotnet add src\OrleansSilo\OrleansSilo.csproj package Microsoft.Orleans.Core --version %ORLEANS_VER%
dotnet add src\OrleansSilo\OrleansSilo.csproj package Microsoft.Orleans.OrleansAzureUtils --version %ORLEANS_VER%
dotnet add src\OrleansSilo\OrleansSilo.csproj package Microsoft.Orleans.OrleansRuntime --version %ORLEANS_VER%
dotnet add src\OrleansSilo\OrleansSilo.csproj package Microsoft.Orleans.Server --version %ORLEANS_VER%

dotnet restore

dotnet build
