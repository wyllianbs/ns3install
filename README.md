# About 

`ns3install.sh` is a simple and easy interactive script for NS3 installation,
development by Prof. [Wyllian Bezerra da Silva](mailto:wyllianbs@gmail.com) at
[Federal University of Santa Catarina (UFSC)](<http://wyllian.prof.ufsc.br/>).


# Installation Instructions

1. Run the script in console, e.g., `bash ns3install.sh` or change the permission (`chmod u+x ns3install.sh`) and run by command line `./ns3install.sh`.

2. Provide the sudo password.

3. If the distro is based on `Debian/Ubuntu` or `RedHat`, all dependencies will be installed. However, if the distro is based other else, check the dependencies before continuing the NS3 installation.

4. Enter the username with sudo privileges. Default: `$USER`. Case the user has not sudo privileges, add him to sudoers modifying the `/etc/sudoers` file (Debian/Ubuntu);

  ```sh
  # User privilege specification
  root    ALL=(ALL:ALL) ALL
  <user>  ALL=(ALL:ALL) ALL # <-- change <user> by username
  ```
5. Set the NS3 installation directory. Default: `/usr/local/ns3`.

6. Provide the latest NS3 release URL. Default: [https://www.nsnam.org/release/ns-allinone-3.26.tar.bz2](https://www.nsnam.org/release/ns-allinone-3.26.tar.bz2).

7. Wait for the next processing pass: 
  - Creating the NS3 path directory.
  - Adding the user `$USER` to group `staff`.
  - Changing permitions on the NS3 directory to `rwx`.
  - Accessing the NS3 path.
  - Downloading the NS3 provided at step 6.
  - Extracting `.tar.bz2` file.
  - Deleting `.tar.bz2` file.
  - Accessing `ns3-allinone` path.
  
8. Confirm the NetAnim version, and press `<ENTER>`.

9. Wait for NS3 building process to complete.
  - NS3 testing process.
  - Adding environment variables on bashfile at `$HOME/.bashrc`.
  
  
# Usage Instructions

1. Standard: use `waf [options] --run <NS3 file path>`. For generating output in the same current working directory path:

  ```sh
  waf --cwd=$PWD --run <NS3 file path>
  ```
  
2. Using optimized options:
  - waf + output in the same current working directory path:
  
    ```sh
    wafo  [options] <NS3 input file path>
     ```
     
  - waf + output in the same current working directory path + visualization:
  
    ```sh
    wafvo [options] <NS3 input file path>
     ```
     
