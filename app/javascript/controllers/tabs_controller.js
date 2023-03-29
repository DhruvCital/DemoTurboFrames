import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["tab"];

    toggle(event) {
        this.tabTargets.forEach(tab => {
            if (tab === event.target) {
                tab.classList.add("active");
            } else {
                tab.classList.remove("active");
            }
        });
    }
}