torpass=$(tor --hash-password $1)
printf "HashedControlPassword $torpass\nControlPort 9051\n" | sudo tee -a /etc/tor/torrc

