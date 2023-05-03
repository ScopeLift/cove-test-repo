set dotenv-load

# Run `just deploy` for a dry run, or `just deploy '--rpc-url $RPC_URL --broadcast'` for the live deploy.
deploy flags='':
  # Save deploy addresses to `deploys.txt`
  just __deploy | grep -E '^(== Logs ==|  FOUNDRY_PROFILE|  CounterBasic|  CounterWithImmutables)' | sed -E 's/(Estimated .*|Script ran successfully\.|SIMULATION COMPLETE.*|Transactions saved.*)//g' > deploys.txt

__deploy flags='':
    #!/usr/bin/env bash
    set -euo pipefail

    profiles=(
        "default"
        "no_optimizer_no_metadata"
        "yes_optimizer_no_metadata"
        "no_via_ir_no_metadata"
        "yes_via_ir_no_metadata"
        "no_metadata_no_cbor"
        "no_metadata_yes_cbor"
    )

    for profile in "${profiles[@]}"; do
        echo -e "\n======== DEPLOYING WITH PROFILE: $profile ========"
        FOUNDRY_PROFILE="$profile" \
            forge script script/DeployCounters.s.sol \
            --skip test \
            -vvv \
            --private-key $DEPLOYER_PRIVATE_KEY \
            {{flags}}
    done
