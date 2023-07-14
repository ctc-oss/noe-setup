## Vagrant VMs

**NOTE**: Some environments do not allow for the synced folder of a VM. So by default the source will be copied via ansible. However, if you wish to use the synced folder that before running any of the belows item set `USE_SYNCED_FOLDER=true`.

- Rocky9 (arm/aarch supported)

  - Easy way

    ```bash
    ./vagrant.sh -a up -r "9" # default is rocky8
    ```

  - Manual way:

    - Not arm/aarch platforms:

      ```bash
      export ROCKY_VERSION="9"
      vagrant up
      ```
    
    - arm/aarch platforms:

      ```bash
      export ROCKY_VERSION="9"
      export OS_ARCH=arm64
      vagrant up
      ```

- Rocky8 (not arm/aarch supported)

  - Easy way:

    ```bash
    ./vagrant.sh -a up
    ```

  - Manual way:
  
    ```bash
    vagrant up
    ```
