# Vaults
General flow: `Vault` accepts a `STRATEGY` Address, funds get sent to this strategy address on deposit. 
The strategy contract (or bot) sends funds to `Harvester` contract. `Harvester` claims rewards for the Vault when a user withdraws from the Vault.

## Using Forge

```sh

# build the artifacts
forge build 
 
```
