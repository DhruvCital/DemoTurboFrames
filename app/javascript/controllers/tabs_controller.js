import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["tab"];

    connect(){
        console.log("tabs connected");
    }

    toggle(event) {
        console.log("tabs toggle");
        this.tabTargets.forEach(tab => {
            if (tab === event.target) {
                tab.classList.add("active");
            } else {
                tab.classList.remove("active");
            }
        });
    }
}