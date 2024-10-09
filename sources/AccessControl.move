module AccessControl::AccessSystem {
    use ReputationManager::ReputationSystem;

    // Access control based on reputation scores
    public fun check_access(user: address, required_reputation: u64): bool {
        let reputation = ReputationSystem::get_reputation(user);
        reputation >= required_reputation
    }
}
