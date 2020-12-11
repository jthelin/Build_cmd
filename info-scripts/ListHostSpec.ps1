# List the machine specification for the host we are running on.
#
# Based on: https://sabin.io/blog/vsts-hosted-build-specs-the-script/
#

$cpu  = Get-WmiObject Win32_Processor
$os   = Get-WmiObject Win32_OperatingSystem
$bios = Get-WmiObject Win32_Bios
$mem  = Get-WmiObject CIM_PhysicalMemory ^
    | Measure-Object -Property Capacity -Sum ^
    | ForEach-Object { [Math]::Round(($_.sum / 1GB), 2) }

Foreach ($c in $cpu) {
    "CPU Name        : " + $c.Name
    "Physical Cores  : " + $c.NumberOfCores
    "Logical  Cores  : " + $c.NumberOfLogicalProcessors
    "L3 Cache Memory : " + $c.L3CacheSize + " KB"
    "Physical Memory : " + $mem + " GB"
    "BIOS Version    : " + $bios.Manufacturer + " " + $bios.SMBIOSBIOSVersion
    "OS Version      : " + $os.Version
}
