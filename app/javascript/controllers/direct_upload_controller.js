import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "progress", "preview"]

  connect() {
    this.inputTarget.addEventListener("direct-upload:initialize", event => {
      const { detail } = event
      const progress = document.createElement("div")
      progress.innerHTML = `
        <div class="progress">
          <div class="progress-bar" role="progressbar" style="width: 0%"></div>
        </div>
      `
      this.progressTarget.innerHTML = ""
      this.progressTarget.appendChild(progress)
    })

    this.inputTarget.addEventListener("direct-upload:progress", event => {
      const { progress } = event.detail
      const progressBar = this.progressTarget.querySelector(".progress-bar")
      progressBar.style.width = `${progress}%`
    })

    this.inputTarget.addEventListener("direct-upload:error", event => {
      this.progressTarget.innerHTML = `<div class="alert alert-danger">Upload failed</div>`
    })

    this.inputTarget.addEventListener("change", event => {
      const file = event.target.files[0]
      if (file) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.previewTarget.innerHTML = `<img src="${e.target.result}" class="img-thumbnail mt-2" style="max-width: 300px">`
        }
        reader.readAsDataURL(file)
      }
    })
  }
}