# Ubuntu after install

Bash scripts for automatic configuration after a fresh install of Ubuntu

## Usage
```sh
# step 1: Add repositories
# default - is the folder in which the configuration data
sudo bash add-repositories.sh default

# step 2: Remove unused packages (you can skip this step)
sudo bash delete-packages.sh default

# step 3: Install & Upgrade packages
sudo bash install.sh default

# step 4: Custom system settings (you can skip this step)
# make sure that script have sudo privileges, but script run under user
sudo su
exit
bash settings.sh
```

## License
Copyright (C) 2015  Andrey Izman

This library is free software; you can redistribute it and/or
modify it under the terms of the [GNU Lesser General Public
License](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html) as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
