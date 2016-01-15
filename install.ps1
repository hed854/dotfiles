# Input parameters
Param(
	[Parameter(Mandatory=$true)][string]$home_dir,
	[Parameter(Mandatory=$true)][string]$7z_exe
)

# Various functions
function Zip-Install
{
	$url = $args[0];
	$bundle_dir = $args[1];

	if(!(Test-Path $bundle_dir/master.zip))
	{
		Write-Host "Installing $url"

		# Download
		$client = new-object System.Net.WebClient 
		$client.DownloadFile("$url/archive/master.zip", "$bundle_dir/master.zip")
	
		# Unzip
		& $7z_exe x $bundle_dir/master.zip "-o$bundle_dir/" -y
	
		# Delete master.zip
		Remove-Item $bundle_dir/master.zip
	}

}

# install directories in windows
$vimrc_name="_vimrc"
$vim_bundle_dir="$home_dir/vimfiles/bundle"
$vim_autoload_dir="$home_dir/vimfiles/autoload"

# Begin script
Write-Host "Installing dotfiles in $home_dir"
Write-Host "========================================"

Write-Host "Copying .vimrc"
Copy-Item -Path .vimrc $home_dir/_vimrc

if((Test-Path $vim_bundle_dir) -And (Test-Path $vim_autoload_dir))
{
	Write-Host "Vim basic dirs... OK!"
}
else
{
	Write-Host "Creating vim basic dirs"
	md $vim_bundle_dir
	md $vim_autoload_dir
}

if(Test-Path $vim_autoload_dir/pathogen.vim)
{
	Write-Host "Pathogen... OK!"
}
else
{
	Write-Host "Installing Pathogen"
	# Invoke-WebRequest/wget is not available in powershell 2.0 (Windows 7)
	$client = new-object System.Net.WebClient 
	# The second argument must be a filename
	$client.DownloadFile("https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim", "$vim_autoload_dir/pathogen.vim")

}

Write-Host "Installing plugins:"
Zip-Install "https://github.com/jeetsukumaran/vim-filebeagle" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/itchyny/lightline.vim" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/tpope/vim-markdown" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/nelstrom/vim-markdown-folding" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/octol/vim-cpp-enhanced-highlight" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/elzr/vim-json" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/hdima/python-syntax" "$vim_bundle_dir" $7z_exe

Write-Host "Installing themes:"
Zip-Install "https://github.com/vim-scripts/desertEx" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/vim-scripts/256-grayvim" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/andrwb/vim-lapis256" "$vim_bundle_dir" $7z_exe
Zip-Install "https://github.com/NLKNguyen/papercolor-theme" "$vim_bundle_dir" $7z_exe
