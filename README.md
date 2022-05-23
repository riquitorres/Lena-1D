This the Release of the Code and setup associated with the manuscript submitted to Biogeochemical letters as:

Biological lability of terrigenous DOC increases CO2 outgassing across Arctic shelves" by Luca Polimene, Ricardo Torres, Helen R. Powley, Michael Bedington, Bennet Juhls, Juri Palmtag, Jens Strauss and Paul J. Mann. BIOG-D-21-00202

The manuscript uses ERSEM and GOTM as the main biogeochemical and hydrodynamic models, and FABM as the coupling code that enables the communication between the hydrodynamic and biogeochemical model. 

The ERSEM code specific to this manuscript is provided here, while the code for GOTM and FABM can be access as described below in this README file. 
The commit versions for each are:

* FABM: 903f899737d1138ce0a4c535c4367fae9bb2a6dc
* GOTM: 2655226f5bc5843650c6e9a7989ec4d4001764b4


ERSEM is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation (https://www.gnu.org/licenses/gpl.html), either version 3 of the License, or (at your option) any later version.
It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
A copy of the license is provided in COPYING.

Copyright 2016 Plymouth Marine Laboratory.

# Obtaining the code and building

## Linux

First obtain the FABM source code:

    git clone https://github.com/fabm-model/fabm.git <FABMDIR>

(Replace `<FABMDIR>` with the directory where you want the FABM code to go, e.g., ~/fabm-git.)

Obtain the ERSEM code for FABM:

    git clone git@github.com:riquitorres/Lena-1D.git <ERSEMDIR>

(Replace `<ERSEMDIR>` with the directory where you want the ERSEM code to go, e.g., ~/ersem-git.)

FABM and ERSEM use object-oriented Fortran and therefore require a recent Fortran compiler, such as Intel Fortran 12.1 or higher and gfortran 4.7 or higher. Compilation is regularly tested with Intel Fortran 12.1, 13.0 and 14.0. as well as gfortran 4.7, 4.8 and 4.9.

FABM and ERSEM use a platform-independent build system based on [cmake](http://www.cmake.org). You'll need version 2.8.8 or higher. First check whether you have that installed: execute `cmake --version` on the command line.

### GOTM + FABM + ERSEM

First obtain the latest (developers') version of the GOTM code from its git repository:

    git clone https://github.com/gotm-model/code.git <GOTMDIR>

(Replace `<GOTMDIR>` with the directory where you want the GOTM code to go, e.g., ~/gotm-git.)

To build GOTM with FABM support, create a build directory, call cmake to generate makefiles, and make to compile and install. For instance:

    mkdir -p ~/build/gotm
    cd ~/build/gotm
    cmake <GOTMDIR>/src -DFABM_BASE=<FABMDIR> -DFABM_ERSEM_BASE=<ERSEMDIR>
    make install

In the above:

* replace `<GOTMDIR>` with the directory with the GOTM code, e.g., ~/gotm-git
* replace `<FABMDIR>` with the directory with the FABM code, e.g., ~/fabm-git
* replace `<ERSEMDIR>` with the directory with the ERSEM code, e.g., ~/ersem-git.

If you experience issues related to NetCDF when running `make install`, see [tips and tricks/troubleshooting](#tips-and-tricks-troubleshooting).

Now you should have a GOTM executable with FABM and ERSEM support at `~/local/gotm/bin/gotm`.

It is good practice to keep up to date with the latest code from the ERSEM, FABM and GOTM repositories by regularly executing `git pull` in a directory of each repository.

If either the ERSEM, FABM or GOTM source codes change (e.g., because changes you made to the code yourself, or after `git pull`), you will need to recompile. This does NOT require rerunning cmake. Instead, you need to return to the build directory and rerun `make install`. For instance `cd ~/build/gotm && make install`.


### Tips and tricks/troubleshooting

General:

* cmake autodetects a suitable Fortran compiler. If a Fortran compiler is not found or you are unhappy with the compiler cmake selected, you can override this by providing cmake with `-DCMAKE_Fortran_COMPILER=<COMPILER_EXECUTABLE>`. Note: if you change CMAKE_Fortran_COMPILER (or provide it for the first time, while you previously ran cmake without), you need to clean (remove everything in) your build directory first!
* When building GOTM or FABM's 0d driver, cmake will try to auto-detect NetCDF using `nf-config`. If nf-config is not present on your system, you'll need to provide cmake with the path(s) to the NetCDF include directories (`-DNetCDF_INCLUDE_DIRS=<PATH>`) and the path(s) to the NetCDF libraries (`-DNetCDF_LIBRARIES=<PATH>`). If you need to provide multiple paths to these variables, the individual paths should be separated by semi-colons. A common reason to use this: On some systems, nf-config does not detect where netcdf.mod is installed, which means you have to tell cmake by adding `-DNetCDF_INCLUDE_DIRS=<PATH_TO_netcdf.mod>`. For instance, when using gfortran on Fedora, `<PATH_TO_netcdf.mod>` can be `/usr/lib64/gfortran/modules`. In that case you usually do not need to provide `-DNetCDF_LIBRARIES=<PATH>`. Also, on some systems (like in the current LTS release of Ubuntu), nf-config is not included in the netcdf packages. In these case, specify `-DNetCDF_CONFIG_EXECUTABLE=<PATH_TO_nc-config>` when calling cmake, or create a link to nc-config somewhere in your default path, to get auto-detection working.
* By default, cmake will select the "release" build type, which creates an executable without debugging information. If you want to compile in debug mode, specify `-DCMAKE_BUILD_TYPE=debug` in the call to cmake. When using gfortran, you may also want to add `-DCMAKE_Fortran_FLAGS_DEBUG=-fcheck=bounds` to catch out-of-bounds array access.
* To see the settings you specified when you ran cmake, and to selectively make changes to these setttings, you can run `ccmake .` in your build directory.
* To speed up compilation, you can perform a parallel build by providing the -j N switch to make (not cmake!), with N being the number of cores you want to use.

Specific platforms:

* [ARCHER](http://www.archer.ac.uk): make sure to first load the cmake and cray-netcdf modules (`module load cmake cray-netcdf`). These enable cmake and autodetection of NetCDF paths, respectively. Provide `-DCMAKE_Fortran_COMPILER=ftn` to cmake to make sure cmake uses Cray's compiler wrapper script for Fortran compilation. Compilation should succeed with the GNU (`module load PrgEnv-gnu`) and the Intel programming environments (`module load PrgEnv-intel`). Compilation with the Cray compiler (`module load PrgEnv-cray`) currently fails due to compiler bugs related to Fortran 2003 support.
* Ubuntu LTS: nf-config is not included in the netcdf packages, but nc-config is. Specify `-DNetCDF_CONFIG_EXECUTABLE=<PATH_TO_nc-config>` when calling cmake, or create a link from nf-config to nc-config somewhere in your default path to get auto-detection of NetCDF paths working.
* Fedora: nf-config does not detect where netcdf.mod is installed (typically in /usr/lib64/gfortran/modules). This means you have to tell cmake by adding `-DNetCDF_INCLUDE_DIRS=/usr/lib64/gfortran/modules`.

## Windows

Note: below are quick-start instructions tailored to Visual Studio. Further information, including instruction for building with the free MinGW compiler, can be found on [the FABM wiki](http://fabm.net/wiki), section "Building and installing".

NB tested with Visual Studio 2010 in combination with Intel Visual Fortran (version 12.1 or higher required).

To obtain the source code of GOTM, FABM and ERSEM, you need a git client. First install [the Windows version of git itself](http://git-scm.com/download/win). For convenience, you can install the graphical git client [TortoiseGit](https://tortoisegit.org/) on top; the following instructions assume you have installed TortoiseGit.

After these two program are installed, you can obtain the code by right-clicking in Windows Explorer within a directory where you want the source code directories, and choosing "Git Clone...". In the window that appears, set the URL, check the target directory and click OK. Do this for the following URLs:

* GOTM: https://github.com/gotm-model/code.git (suggested target directory: gotm-git)
* FABM: https://github.com/fabm-model/fabm.git (suggested target directory: fabm-git)
* ERSEM: git@gitlab.ecosystem-modelling.pml.ac.uk:edge/ersem.git (suggested target directory: ersem-git). For this repository, you also need to provide your private SSH key, which must match the public key that you provided on [the PML GitLab site](https://gitlab.ecosystem-modelling.pml.ac.uk/profile/keys). To do so, check "Load Putty key" and set its path to the file with your private key. For creating private/public keys, we suggest using [PuTTYgen](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html).

To compile the code, you need [CMake](http://www.cmake.org/). If CMake is installed, open "CMake (cmake-gui)", specify GOTM's `src` directory for "Where is the source code", choose a directory of your choice (but outside the source directory!) for "Where to build the binaries", and click Configure. Choose the generator that matches your Visual Studio version (avoid the IA64 and Win64 options) and click Finish. Several configuration options will appear, among which `FABM_BASE`. This option must be set to the directory with the FABM source code (the root directory, not the `src` subdirectory). After doing so, click "Configure". Then a new option `FABM_ERSEM_BASE` will appear, which must be set to the path to the directory with ERSEM source code (the root directory, not the `src` subdirectory). Keep clicking "Configure" until there are no red-coloured options left. Then press "Generate". This will create a `gotm.sln` Visual Studio solution in the specified build directory, which you can now open with Visual Studio.

Note that it is good practice to keep up to date with the latest code from the GOTM, FABM and ERSEM repositories by regularly right-clicking the repository directory, choosing "Git Sync...", and clicking the "Pull" button in the window that then appears.


