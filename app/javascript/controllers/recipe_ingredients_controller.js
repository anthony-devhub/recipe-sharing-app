// app/javascript/controllers/recipe_ingredients_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const recipeId = this.element.dataset.recipeId

    fetch(`/recipes/${recipeId}/ingredients_async`)
      .then(response => response.text())
      .then(html => {
        this.element.innerHTML = html
      })
  }
}
