#!/bin/bash

rm -vrf build/
rm -vrf delivery/
rm -vrf docs/

echo "Deleting other folders, maybe they do not exist."
rm -vrf .cache/
