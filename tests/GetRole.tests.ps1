


Describe "Private Function - GetRole" { 

    $ymlFile = gc $psscriptroot/etc/Software.yml -raw

    It "test Yaml is valid." {
        {$obj = ConvertFrom-Yaml -Yaml $ymlFile -AllDocuments} | Should not throw
    }

    Context "Well formatted YAML." {

        InModuleScope -ModuleName RoleParser -ScriptBlock {

            $role = GetRole -etc $psscriptroot/etc -name Software

            It "GetRole gets the role structure." {
                $role | should be $true
            }

            it "Role is root." { 
                $role.RoleName | should be "ServerSoftware"
            }

            it "Role has children." {
                $role.Children.Count -gt 1 | should be $true
            }
            
        }

    }

    Context "Poor formatted YAML." {


        InModuleScope -ModuleName RoleParser -ScriptBlock { 


            it "Should terminate due to recursed role." {
                { GetRole -etc $psscriptroot/etc -name SoftwareBad } | should throw
            }
        }
    }

}