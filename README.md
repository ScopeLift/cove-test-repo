# Cove Test Repo

Contains test contracts and deployment scripts for the [Cove](https://github.com/ScopeLift/cove-backend) contract verification service.

There are two contracts, `CounterBasic` and `CounterWithImmutables`.
Deploys are managed with the `justfile`, so you'll need to install [just](https://github.com/casey/just) to run them.

Next, copy the `.env.template` file and fill in the private key and RPC URL you want to use for deployment.

Then run `just deploy` for a dry run, or `just deploy '--broadcast'` for the live deploy. These commands will:

- Compile the contracts with each profile defined in `foundry.toml`, which has many profiles using different solc settings.
- For each, run the `DeployCounters.s.sol` script which deploys both contracts using create and create2.
- Saves the deployment addresses to [`deploys.txt`](./deploys.txt).

Note that dry run addresses are also saved to `deploys.txt`, so if you don't want to commit those (which you probably don't), you'll need to remove them manually.
