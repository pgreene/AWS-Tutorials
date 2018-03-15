## Packer

### Notes
* First Build the AMI in AWS that terraform will use
* This is a scaled down version of a previously tested packer config
* If you run into any issues please file a bug in my git repo

### Usage

```bash
packer validate bastion.json
packer build bastion.json
```
