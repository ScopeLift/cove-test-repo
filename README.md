# Cove Test Repo

Contains test contracts and deployment scripts for the [Cove](https://github.com/ScopeLift/cove-backend) contract verification service.

There are two contracts, `CounterBasic` and `CounterWithImmutables`.
Running `just deploy` for a dry run, or `just deploy '--rpc-url $RPC_URL --broadcast'` for the live deploy will:

- Compile the contracts with each profile defined in `foundry.toml`, which has many profiles using different solc settings.
- For each, run the `DeployCounters.s.sol` script which deploys both contracts using create and create2.
- Saves the deployment addresses to [`deploys.txt`](./deploys.txt).

To deploy, copy the `.env.template` file and fill in the private key you want to use for deployment.
