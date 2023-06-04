
function testpipe{
    Param($block)
    begin{
        $null = Remove-Job -Name "pipejob-*" -Force
    }
    process {
        $runningJobs = (Get-Job -Name "pipejob-*" | ?{ $_.State -eq 'Running' })

        if($runningJobs.Count -gt 10){
            $runningJobs | Wait-Job -Any
        }

        $null = (Start-Job -Name "pipejob-$_" ($block) -ArgumentList $_)

        (Get-Job -Name "pipejob-*" | ?{ $_.State -eq 'Completed' } | Receive-Job -Wait -AutoRemoveJob)
    }
    end{
        Receive-Job -Name "pipejob-*" -Wait -AutoRemoveJob
    }
}

1..10 | testpipe {
    param($num)
    $num + 99
}
