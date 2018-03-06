# .NET Core 2 Preview 1 Raffler

To develop this locally on Linux you could take something similar to these steps:

1. Go to https://www.microsoft.com/net/core/preview#linuxubuntu
1. Follow the instructions to install ".NET Command Line Tools (2.0.0-preview1-005977)"
1. Go to the `src` folder and do `dotnet restore` 
1. Use `dotnet test Raffler.Tests` to run the unit tests
1. Use `dotnet run -p Raffler/Raffler.csproj ../../example_names` to do a test run

Recommended to use e.g. VSCode to edit all this stuff.

## Verifying the Docker Container

In the root of the project run:

``` sh
sudo make test RAFFLER=jeroenheijmans-netcore2
```

And see the output:

> Winner, winner, chicken dinner.