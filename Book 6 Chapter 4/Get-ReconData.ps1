function Get-ReconData 
{
    [CmdletBinding()]
    Param (
        [string[]] $computername
    )
    BEGIN {
        Write-Output "Gathering reconnaissance on $computername"
    }
    PROCESS {
            foreach ($computer in $computername) {
            $os = Get-WmiObject -class Win32_OperatingSystem -computerName $computer
            $comp = Get-WmiObject -class Win32_ComputerSystem -computerName $computer
            $prop = @{'ComputerName'=$computer;
                    'OSVersion'=$os.version;
                    'SPVersion'=$os.servicepackmajorversion;
                    'FreeMem'=$os.FreePhysicalMemory;
                    'OSType'=$os.OSType;
                    'Domain'=$comp.domain;
                    'Status'=$comp.Status}
            $sysinfo = New-Object -TypeName PSObject -Property $prop
            Write-Output $sysinfo}
    }
    END {}
}
