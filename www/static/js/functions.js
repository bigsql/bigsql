function selectItem(elementId, selectedOption) {
    options = document.getElementById(elementId).options
    for (var i = 0; i < options.length; i++) {
        if (options[i].value == selectedOption)
            options[i].selected = true;
    }
}

function enableChanged(button, field, origValue) {
    if (origValue != document.getElementById(field).value) {
        document.getElementById(button).disabled = false;
    } else {
        document.getElementById(button).disabled = true;
    }
    return true;
}

function checkSame(elementA, elementB, submitButton) {
    if (document.getElementById(elementA).value == document.getElementById(elementB).value) {
        document.getElementById(submitButton).disabled = false;
    } else {
        document.getElementById(submitButton).disabled = true;
    }
    return true;
}

function enableSingleField(field, button) {
    if (document.getElementById(field).value != "") {
        document.getElementById(button).disabled = false;
    } else {
        document.getElementById(button).disabled = true;
    }
    return true;
}

function enableDoubleFields(fieldA, fieldB, button) {
    if (document.getElementById(fieldA).value != "" && document.getElementById(fieldB).value != "") {
        document.getElementById(button).disabled = false;
    } else {
        document.getElementById(button).disabled = true;
    }
    return true;
}

$(document).ready(function() {
    $(window).scroll(function() {
        if ($(this).scrollTop() > 50) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });
    // scroll body to 0px on click
    $('#back-to-top').click(function() {
        $('#back-to-top').tooltip('hide');
        $('body,html').animate({
            scrollTop: 0
        }, 800);
        return false;
    });

    $('#back-to-top').tooltip('show');


    $(".expand").on( "click", function() {
    $(this).next().slideToggle(200);
    $expand = $(this).find(">:first-child");
    
    if($expand.text() == "+") {
      $expand.text("-");
    } else {
      $expand.text("+");
    }
  });

});

document.addEventListener('DOMContentLoaded', function() {
    function setButtonHTML(opf) {
        var dlb = document.getElementById('dl-button-wrapper');

        if (opf != "unsupported") {

            if (opf === "MacIntel") {
                dlOS = "osx"
                dlOSimg = "osx.png"
                dlOSText = "macOS"
                osLink = allLinks[1].href;
                osDLtext = allLinks[1].text;
                dlid = "dlbtn-osx";
            } else if (opf === "Win32") {
                dlOS = "w64"
                dlOSimg = "windows.svg"
                dlOSText = "Windows"
                osLink = allLinks[0].href;
                osDLtext = allLinks[0].text;
                dlid = "dlbtn-win";
            }
            var DL_HTML_SKELETON = "";
            DL_HTML_SKELETON += "<a id=\"" + dlid + "\" href=\"" + osLink + "\" class=\"btn btn-default btn-lg\">";
            DL_HTML_SKELETON += "<img width=\"40\" class=\"os-dl-image\" src=\"\/bigsql\/static\/img\/" + dlOSimg + "\" alt=\"\">";
            DL_HTML_SKELETON += "<span class=\"dl-os-text\">Download for " + dlOSText + "<\/span><br\/>";
            DL_HTML_SKELETON += "<span class=\"os-dl-text\">" + osDLtext + "<\/span>";
            DL_HTML_SKELETON += "<\/a>";
            dlb.innerHTML = DL_HTML_SKELETON;

        } else {
            var pgin = document.getElementById('pg-installers');
            pgin.removeChild(document.querySelector('.col-md-5'));
            pgin.children[0].className += " col-md-12";
            pgin.children[0].className = pgin.children[0].className.replace(/(?:^|\s)col-md-7(?!\S)/g, '');
        };
    }

    if ((document.location.pathname.indexOf("postgresql/installers") != -1 || document.location.pathname === "/bigsql/postgresql/" || document.location.pathname == '/postgresql/' || document.location.pathname === "/bigsql/postgresql/installers.jsp" || document.location.pathname === "/postgresql/installers.jsp") && document.location.pathname.indexOf("postgresql/installers/sandboxes") == -1) {
        var pf = navigator.platform;
        var allLinks = document.querySelectorAll('#pg-installers #pg96 A');
        if (document.location.hash === "") {
            if (pf === "MacIntel" || pf === "Win32") { setButtonHTML(pf); } else { setButtonHTML("unsupported"); };
        } else if (document.location.hash === "#windows") {
            setButtonHTML("Win32");
        } else if (document.location.hash === "#macos") {
            setButtonHTML("MacIntel");
        } else if (document.location.hash === "#unsupported") {
            setButtonHTML("unsupported");
        } else {
            if (pf === "MacIntel" || pf === "Win32") { setButtonHTML(pf); } else { setButtonHTML("unsupported"); };
        };
    };


    
    function makeRequest(url) {
        httpRequest = new XMLHttpRequest();

        if (!httpRequest) {
            console.log('Giving up :( Cannot create an XMLHTTP instance');
            return false;
        }
        httpRequest.onreadystatechange = consumeJSONFromYQL;
        httpRequest.open('GET', url);
        httpRequest.send();
    }

    if (null != document.getElementById('oscg-rss-feed--body')) {
      var yql = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20rss%20where%20url%3D%22https%3A%2F%2Fopenscg.com%2Ffeed%22&format=json&diagnostics=true&callback=";
      makeRequest(yql);
    }

    function GetFormattedDate(date) {
        var month = date .getMonth() + 1;
        if(month<10){
            month = '0'+month;
        }
        var day = date .getDate();
        if(day<10){
            day = '0' + day;
        }
        var year = date .getFullYear();
        return year+'-'+month+'-'+day;  
    }

    function consumeJSONFromYQL() {
        if (httpRequest.readyState === XMLHttpRequest.DONE) {
            if (httpRequest.status === 200) {
                var res = JSON.parse(httpRequest.responseText);
                for (var i = 0; i < res.query.results.item.length; i++) {
                    lk = res.query.results.item[i].link + "?utm_source=bigsql&utm_medium=bloglist&utm_campaign=blog";
                    var pubDate = GetFormattedDate(new Date(res.query.results.item[i].pubDate));
                    document.getElementById('oscg-rss-feed--body').insertAdjacentHTML('beforeend', "<li>"+pubDate+"<br><a onclick=\"trackOutboundLink('" + lk + "'); return !ga.loaded;\" href='" + lk + "'>" + res.query.results.item[i].creator+":&nbsp"+res.query.results.item[i].title + "</a></li>");
                };
            } else {
                console.log('There was a problem with the request.');
            }
        }
    }

});
