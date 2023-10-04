function Get-PWPartNumber
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int32]$Numberinbatch = 4
    )

    $meinpw_n = @()
    $meinpw_n += 0..9 # Zahlen 
    $meinpw_n_out = (Get-Random -InputObject $meinpw_n -Count $Numberinbatch) -join ""
    return $meinpw_n_out
}

function Get-PWPartlowercase
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int32]$Numberinbatch = 4
    )
    
    $meinpw_lc = @()         
    $meinpw_lc += [char[]]([char]97..[char]122) # Kleinbuchstaben
    $meinpw_lc_out = (Get-Random -InputObject $meinpw_lc -Count $Numberinbatch) -join "" 
    return $meinpw_lc_out
}

function Get-PWPartuppercase
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int32]$Numberinbatch = 4
    )

    $meinpw_uc = @()            
    $meinpw_uc += [char[]]([char]65..[char]90) # Grossbuchstaben 
    $meinpw_uc_out = (Get-Random -InputObject $meinpw_uc -Count $Numberinbatch) -join ""
    return $meinpw_uc_out
}

function Get-PWPartdelimiter
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [bool]$easytoreaddelimeter = $false
    )    
    
    $meinpw_d_hard = @("_",",",".","-","#","+","*","~","%","!",":",";","<",">","(",")","[","]","{","}","~")
    $meinpw_d_easy = @("_",".","-","#","+","!")

    if($easytoreaddelimeter)
    {
        $meinpw_d_out = (Get-Random -InputObject $meinpw_d_easy -Count 1) -join ""
    }
    else
    {
        $meinpw_d_out = (Get-Random -InputObject $meinpw_d_hard -Count 1) -join ""
    }
    return $meinpw_d_out
}

function Get-PWPartRandomCategory
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int32]$Numberinbatch = 4
    )

    $meinpw_rc = @()
    $meinpw_rc += 1..3
    switch (Get-Random -InputObject $meinpw_rc -Count 1) 
    {
        "1" {return Get-PWPartNumber $Numberinbatch}
        "2" {return Get-PWPartlowercase $Numberinbatch}
        "3" {return Get-PWPartuppercase $Numberinbatch}
    }

}

function Get-RandomPassword()
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [int32]$Numberinbatch = 4,

        [Parameter(Mandatory=$false)]
        [bool]$easytoreaddelimeter = $false,

        [Parameter(Mandatory=$false)]
        [bool]$randomisebatchcategory = $false,

        [Parameter(Mandatory=$false)]
        [ValidateRange(3, 128)]
        [int32]$Numberofbatchifrandom = 6
    )

    if($randomisebatchcategory)
    {
        $Password = Get-PWPartRandomCategory $Numberinbatch

        for($i=1 ; $i -le $Numberofbatchifrandom;$i++)
        {
            $Password = $Password + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartRandomCategory $Numberinbatch)
        }
    }
    else
    {
        $randomswitch = Get-Random -InputObject ([bool]$True,[bool]$False) -Count 1
        $randomswitch2 = Get-Random -InputObject ([bool]$True,[bool]$False) -Count 1
        $randomswitch3 = Get-Random -InputObject ([bool]$True,[bool]$False) -Count 1

        if($randomswitch)
        {
            if($randomswitch2)
            {
                $Password = $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartuppercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartlowercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch)
            }
            else
            {
                if($randomswitch3)
                {
                    $Password = $(Get-PWPartuppercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartuppercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartlowercase $Numberinbatch)
                }
                else
                {
                    $Password = $(Get-PWPartuppercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartlowercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartlowercase $Numberinbatch)
                }
            }   
        }
        else
        {
            if($randomswitch2)
            {
                $Password = $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartlowercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartuppercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch)
            }
            else
            {
                if($randomswitch3)
                {
                    $Password = $(Get-PWPartlowercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartlowercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartuppercase $Numberinbatch)
                }
                else
                {
                    $Password = $(Get-PWPartlowercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartuppercase $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartNumber $Numberinbatch) + $(Get-PWPartdelimiter $easytoreaddelimeter) + $(Get-PWPartuppercase $Numberinbatch)
                }
            }    
        }
    }

    return $Password
}
