module SocialIntegration::SocialIntegrationSystem {
    use 0x1::Table;
    use IDVerse::IDVerseSystem;

    // Struct to store linked social accounts
    resource struct SocialConnections has key {
        accounts: table::Table<address, vector<u8>>, // Linked social accounts
    }

    // Link a social media account to the user's NeoID
    public fun link_social_account(account: &signer, platform: vector<u8>) acquires SocialConnections {
        let addr = Signer::address_of(account);
        if (!exists<SocialConnections>(addr)) {
            let connections = SocialConnections {
                accounts: table::new<address, vector<u8>>(),
            };
            move_to(account, connections);
        }
        let connections = borrow_global_mut<SocialConnections>(addr);
        table::add(&mut connections.accounts, addr, platform);
    }

    // Get linked social account
    public fun get_linked_account(account: address): vector<u8> {
        let connections = borrow_global<SocialConnections>(account);
        table::borrow(&connections.accounts, account)
    }
}
