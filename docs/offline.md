## Offliine Support

### Downloading Files

To get all files needed for an offline deployment, the following software will need to installed on the local machine:

- `ansible`
- `docker`

Once you have those installed, run:

```bash
ansible-playbook -v provisioning/offline_download.yml
```

This will download all the files needed to `provisioning/roles/offline-download/files/offline-files`. To move these over zip the folder and then extract in the SAME location on the offline machine. The other provisioning code will look inside of `provisioning/roles/offline-download/files/offline-files` when deploying offline so make sure the proper contents are there.

### Deploying

**NOTE**: This example is running the provisioning on a already made RHEL8/ROCKY8 or RHEL9/ROCKY9 machine. Since being offline, to be able to use `Vagrant` some additional steps would be needed that we are not going to look into at the moment.

**Prereqs**:

To deploy offline make sure:

- Created a RHEL8/ROCKY8 or RHEL9/ROCKY9 VM with `ansible` installed.
- The extracted content of the offline files are inside of `provisioning/roles/offline-download/files/offline-files`.
- If wanting to use custom yum repos make sure to set the varaiable `OFFLINE_YUM_REPO_LOCATION`.
  - When setting this variable append either `local:` or `remote:` to the beginning if providing a file path. This will help ensure if copying the file from one place to another that we know wheter its from the machine running the ansible or the machine being created.
  - However, if this is a URL starting with `http` or `https` it will try downloading that file to the proper location.

**Run provisioning**:

- Update the `provisioning/setup_machine.yml` to set `- hosts: all` to `- hosts: localhost`.

- Run:

  ```bash
  ansible-playbook \
    --extra-vars is_offline=true \
    provisioning/setup_machine.yml
  ```
