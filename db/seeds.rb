# Create dummy users
u1 = User.create(username: "ASU_Student", email: "student@asu.edu")
u2 = User.create(username: "Textbook_Seller", email: "books@asu.edu")

# Create dummy listings
Listing.create(title: "Calculus Early Transcendentals", description: "Used, good condition", price: 45.00, user: u1)
Listing.create(title: "Herman Miller Chair", description: "Moving out sale", price: 150.00, user: u2)
Listing.create(title: "MacBook Pro M1", description: "Lightly used", price: 800.00, user: u1)