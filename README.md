# Clean lib32 packages!

Remove unneeded lib32 packages from your Arch Linux system.

# Description

Use this command-line script when you feel you have too much lib32 packages installed and you want to cleanup your system.

Ok, but how does it work?

Each time you run it, it will look for lib32 packages currently marked as "installed as dependency for another package" in the "Install Reason" (pacman -Qi <pkg>). If listed packages are desnecessary, it will uninstall them, with user's approval.

You'll probably want to run this script more than once, as some lib32 might be not necessary anymore after uninstalling another one.

P.S.: packages not marked as "installed as dependency" will not be listed neither removed.

# Contributing

If you found it in [Arch User Repository] (https://aur.archlinux.org/packages/cleanlib32/) and decided that you want to contribute to this software, please fork it on [GitHub] (https://github.com/josephgbr/cleanlib32), push your change to a named branch, then send me a pull request.

You can also help me reach an users in your language. With [Transifex] (https://www.transifex.com/projects/p/cleanlib32/), you can help translate this software into your own language.

# License

The source code is licensed under the [GNU General Public License Version 3] (https://www.gnu.org/licenses/gpl.html), which you can find in the COPYING file.
