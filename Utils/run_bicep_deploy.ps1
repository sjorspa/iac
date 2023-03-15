az deployment group create --resource-group 'KPN DCI ACC' `
         --template-file '.\Pipelines\Infrastructure\templates\virtualMachines.bicep' `
         --parameters `
            location='${{variables.location}}' `
            virtualMachineName='temp_vm_sjors' `
            virtualMachineAdminUsername='sjors' `
            virtualMachineAdminPasswordOrPublicKey='HHUlfsdf8792y4982!!!!$$$@@'