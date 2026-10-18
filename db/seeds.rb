# frozen_string_literal: true

books = [
  { name: "The Hobbit", author: "J.R.R. Tolkien", page_quantity: 310 },
  { name: "The Fellowship of the Ring", author: "J.R.R. Tolkien", page_quantity: 423 },
  { name: "The Two Towers", author: "J.R.R. Tolkien", page_quantity: 352 },
  { name: "The Return of the King", author: "J.R.R. Tolkien", page_quantity: 416 },
  { name: "The Silmarillion", author: "J.R.R. Tolkien", page_quantity: 365 },
  { name: "Harry Potter and the Philosopher's Stone", author: "J.K. Rowling", page_quantity: 223 },
  { name: "Harry Potter and the Chamber of Secrets", author: "J.K. Rowling", page_quantity: 251 },
  { name: "Harry Potter and the Prisoner of Azkaban", author: "J.K. Rowling", page_quantity: 317 },
  { name: "1984", author: "George Orwell", page_quantity: 328 },
  { name: "Animal Farm", author: "George Orwell", page_quantity: 112 },
  { name: "Dune", author: "Frank Herbert", page_quantity: 688 },
  { name: "Foundation", author: "Isaac Asimov", page_quantity: 255 },
  { name: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", page_quantity: 224 },
  { name: "The Hunger Games", author: "Suzanne Collins", page_quantity: 374 },
  { name: "Fahrenheit 451", author: "Ray Bradbury", page_quantity: 194 }
]

books.each do |attributes|
  book = Book.find_or_initialize_by(
    name: attributes[:name],
    author: attributes[:author]
  )

  book.page_quantity = attributes[:page_quantity]
  book.save!
end

puts "Seed completed! Total books: #{Book.count}"

