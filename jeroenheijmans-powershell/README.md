# JeroenHeijmans-Powershell Raffler

This raffler uses [PowerShell](https://github.com/PowerShell/PowerShell) on Linux in a Docker container to randomly pick a winner. Skips white lines.

## Testing

Run this in the root of the project to verify:

```sh
sudo make test RAFFLER=jeroenheijmans-powershell
```