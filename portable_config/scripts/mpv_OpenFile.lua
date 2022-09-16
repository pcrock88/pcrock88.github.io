utils = require 'mp.utils'
function open_file_dialog()
	local was_ontop = mp.get_property_native("ontop")
	if was_ontop then mp.set_property_native("ontop", false) end
	local res = utils.subprocess({
		args = {'powershell', '-NoProfile', '-Command', [[& {
			Trap {
				Write-Error -ErrorRecord $_
				Exit 1
			}
			Add-Type -AssemblyName PresentationFramework
			$u8 = [System.Text.Encoding]::UTF8
			$out = [Console]::OpenStandardOutput()
			$ofd = New-Object -TypeName Microsoft.Win32.OpenFileDialog
			$ofd.Multiselect = $true
			If ($ofd.ShowDialog() -eq $true) {
				ForEach ($filename in $ofd.FileNames) {
					$u8filename = $u8.GetBytes("$filename`n")
					$out.Write($u8filename, 0, $u8filename.Length)
				}
			}
		}]]},
		cancellable = false,
	})
	if was_ontop then mp.set_property_native("ontop", true) end
	if (res.status ~= 0) then return end

	local first_file = true
	for filename in string.gmatch(res.stdout, '[^\n]+') do
		mp.commandv('loadfile', filename, first_file and 'replace' or 'append')
		first_file = false
	end
end
mp.add_key_binding('ctrl+o', 'open-file-dialog', open_file_dialog)