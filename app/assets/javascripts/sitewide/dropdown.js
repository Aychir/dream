/* When the user clicks on the button, 
toggle between hiding and showing the dropdown content */
function postDropdownFunction() {
    document.getElementById("settings-dropdown").classList.toggle("show");
}

function copyPostUrlFunction(url) {
    console.log(url);
    var temp = document.createElement("input");
    document.body.appendChild(temp);
    temp.setAttribute('value', url);
    temp.select();
    document.execCommand("copy");
    document.body.removeChild(temp);
    //set better alert to say that the link was copied
    alert("Link has been copied!")
}

// Hide post based on html id of the post based on actual post id
function hidePostFunction(postID) {
    document.getElementById(postID).style.display = "none";
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('#settings-button') && !event.target.matches('.fa-ellipsis-v')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}