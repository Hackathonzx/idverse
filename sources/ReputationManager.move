module ReputationManager::ReputationSystem {
    use 0x1::Signer;
    use 0x1::Vector;
    use IDVerse::IDVerseSystem;

    // Struct to store user reputation scores
    resource struct Reputation has key {
        score: u64,
    }

    // Initialize the reputation for a user
    public fun init_reputation(account: &signer) {
        let addr = Signer::address_of(account);
        let reputation = Reputation { score: 0 };
        move_to(account, reputation);
    }

    // Update reputation score
    public fun update_reputation(account: address, new_score: u64) {
        let reputation = borrow_global_mut<Reputation>(account);
        reputation.score = new_score;
    }

    // Retrieve a user's reputation score
    public fun get_reputation(account: address): u64 {
        let reputation = borrow_global<Reputation>(account);
        reputation.score
    }
}
