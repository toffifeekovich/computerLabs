#!/bin/bash

echo
echo "===================="
echo "   PASSPHRASE:"
echo "   e7qVM29pu"
echo "===================="
echo

echo "Запуск SSH..."
ssh -i "$HOME/Documents/sourse-code/computerLabs/doc/linkey25_priv" -p 2222 evm133@84.237.52.21
