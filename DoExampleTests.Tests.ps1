# Run these tests
## PS1> Invoke-Pester
## PS1> Invoke-Pester ".\DoExampleTests.Tests.ps1"
## PS1> Invoke-Pester -Tag Unit
## PS1> Invoke-Pester -Tag Integration
## PS1> Invoke-Pester -Tag Acceptance

Describe 'Check if tests are working one passed and one failed (without any Tag)' {
    It "A always failing test" {
        $false | Should Be $true
    }

    It "A always successfull test" {
        $true | Should Be $true
    }   
}

Describe 'Check if tests are working one passed and one failed (with Tag Unit)' -Tags 'Unit' {
    It "A always failing test" {
        $false | Should Be $true
    }

    It "A always successfull test" {
        $true | Should Be $true
    }   
}

Describe 'Check if tests are working one passed and one failed (with Tag Integration)' -Tags 'Integration' {
    It "A always failing test" {
        $false | Should Be $true
    }

    It "A always successfull test" {
        $true | Should Be $true
    }   
}

Describe 'Check if tests are working one passed and one failed (with Tag Acceptance)' -Tags 'Acceptance' {
    It "A always failing test" {
        $false | Should Be $true
    }

    It "A always successfull test" {
        $true | Should Be $true
    }   
}