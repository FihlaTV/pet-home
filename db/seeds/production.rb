Category.create!([
  {
    name: "Pet Sitters",
    description: "Find available pet sitters nearby."
  },
  {
    name: "Sitters Wanted",
    description: "Require pet sitters."
  },
  {
    name: "Adoption",
    description: "Adoption posts go here."
  },
  {
    name: "Miscellaneous",
    description: "Posts belong to other categories."
  }
])
categories = Category.all
