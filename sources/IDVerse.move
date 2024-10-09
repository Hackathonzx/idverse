module IDVerse::IDVerseSystem {
    use 0x1::Signer;
    use 0x1::Vector;

    // Struct to store basic ID details
    struct NeoID has key {
        id: u64,
        owner: address,
        data: vector<u8>, // Data linked to the ID (e.g., user info, metadata)
    }

    // Global counter to track next available ID
    resource struct IDCounter has key {
        counter: u64,
    }

    // Initialize ID system
    public fun init(account: &signer) {
        assert!(!exists<IDCounter>(Signer::address_of(account)), 1);
        let counter = IDCounter { counter: 0 };
        move_to(account, counter);
    }

    // Register a new ID
    public fun register_id(account: &signer, data: vector<u8>) {
        let addr = Signer::address_of(account);
        let counter = borrow_global_mut<IDCounter>(addr);
        let id = counter.counter;
        counter.counter = id + 1;

        let new_id = NeoID { id, owner: addr, data };
        move_to(account, new_id);
    }

    // Retrieve the ID of an account
    public fun get_id(account: address): u64 {
        let user = borrow_global<NeoID>(account);
        user.id
    }

    // Retrieve the metadata linked to a NeoID
    public fun get_data(account: address): vector<u8> {
        let user = borrow_global<NeoID>(account);
        user.data
    }
}
