# Vaults
General flow is users `Vault` accepts a `STRATEGY` Address, funds get sent to this strategy address on deposit. 
The strategy contract (or bot) sends funds to `Harvester`. `Harvester` claims rewards for the Vault when a user withdraws.

## Using Forge

```sh

# build the artifacts
forge build 
 
```
