import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ingredientsList", "template"]

  add(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.ingredientsListTarget.insertAdjacentHTML("beforeend", content)
  }

  remove(event) {
    event.preventDefault()
    const wrapper = event.target.closest(".ingredient-fields")
    wrapper.remove()
  }
}
