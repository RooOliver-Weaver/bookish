import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="book-form"
export default class extends Controller {
  static targets = ["authorInput", "genreInput"];

  connect() {
    console.log("BookFormController connected");
  }

  async addAuthor(event) {
    event.preventDefault();
    const name = this.authorInputTarget.value;

    const response = await fetch("/authors", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ author: { name: name } })
    });

    if (response.ok) {
      const author = await response.json();
      console.log("Author added:", author);
      this.authorInputTarget.value = ""; // Clear input
    } else {
      console.error("Error adding author:", await response.text());
    }
  }

  async addGenre(event) {
    event.preventDefault();
    const name = this.genreInputTarget.value;

    const response = await fetch("/genres", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ genre: { name: name } })
    });

    if (response.ok) {
      const genre = await response.json();
      console.log("Genre added:", genre);
      this.genreInputTarget.value = ""; // Clear input
    } else {
      console.error("Error adding genre:", await response.text());
    }
  }
}
