
var notificationEnabled = false;
var notifyAPILoop = 0;
var notifyAPISetTimeout;

//cmsSetCookie('cms.Models.Entity.ID', new_me.CookieID, null, null, cmsCookieHost, false)
//cmsSetCookie(name, value, expires, path, domain, secure)


/*
if (notificationEnabled) {
    Notification.requestPermission().then(function (result) {
        //tsh_spawnNotification2("Mable", "Our sweet Mable is sure to steal your heart! With her gorgeous brindle coat and shining hazel eyes, she's truly a sight to behold. Mable is a two month old Hound/German Shepherd mix who arrived at Bideawee along with her siblings: Mac, Martin, and Mollie.", "/Pet/34548451");
        //tsh_spawnNotification2("Get Active!", "Get Active for Animals! Work up a sweat for Bideawee’s homeless animals! Whether you’re a walker, runner, biker, swimmer, or someone in need of a little extra incentive to get moving, consider challenging yourself to get active for animals! Ask your friends to sponsor your efforts, and help you and Bideawee’s four-legged friends in the process.", "/Get-Involved-Bideawee-Get-Active");
        tsh_spawnNotification2("In Honor Of Petey Cramp", "GOAL:   $700\nRAISED:    $325", "/Get-Involved-Bideawee-Celebrations");
       });
}
*/

function timeout_spawnNotification() {

    if (notificationEnabled) {
        Notification.requestPermission().then(function (result) {
            if (notifyAPILoop > 3) notifyAPILoop = 0;

            if (notifyAPILoop == 0) {
                tsh_spawnNotification2("Welcome!", "Welcome to our notification service. If you need to change your interests, click here to visit your profile page.", "/Profile", '/Media/Image/_Notifications/notification-115x115.png');
            }
            else if (notifyAPILoop == 1) {
                tsh_spawnNotification2("Get Active!", "Get Active for Animals! Work up a sweat for Bideawee’s homeless animals! Whether you’re a walker, runner, biker, swimmer, or someone in need of a little extra incentive to get moving, consider challenging yourself to get active for animals! Ask your friends to sponsor your efforts, and help you and Bideawee’s four-legged friends in the process.", "/Get-Involved-Bideawee-Get-Active", '/Media/Image/_Notifications/get-active.png');
            }
            else if (notifyAPILoop == 2) {
                tsh_spawnNotification2("In Honor Of Petey Cramp", "GOAL:   $700\nRAISED:    $325", "/Get-Involved-Bideawee-Celebrations", '/Media/Image/_Notifications/petey-cramp.png');
            }
            else if (notifyAPILoop == 3) {
                tsh_spawnNotification2("In Honor Of Petey Cramp", "GOAL:   $700\nRAISED:    $325", "/Get-Involved-Bideawee-Celebrations", '/Media/Image/_Notifications/petey-cramp.png');
            }
            notifyAPILoop++;

            notifyAPISetTimeout = setTimeout("timeout_spawnNotification()", 20 * 1000)
        });
    }
}

function cmsApiNotifyShowReveal() {
    $('#cms-api-notify').foundation('reveal', 'open');
}

function cmsApiNotifyButtonOKClicked() {
    cmsSetCookie('notifyAPI.Permission', '79dcf002-91f0-46b3-91e6-2b55307f74cf', null, null, null, false);
    notifyAPISetTimeout = setTimeout("timeout_spawnNotification()", 10 * 1000)

    $('#cms-api-notify').foundation('reveal', 'close');
}

function cmsApiNotifyButtonCancelClicked() {
    $('#cms-api-notify').foundation('reveal', 'close');
}

function tsh_spawnNotification2(theTitle, theBody, theUrl, theIcon) {
    /*
    var theIcon = '/Media/Image/_Notifications/notification-115x115.png';
    //theIcon = '/Media/Image/_Notifications/Pets/mable.jpg';
    theIcon = '/Media/Image/_Notifications/get-active.png';
    theIcon = '/Media/Image/_Notifications/petey-cramp.png';
    */
    var options = {
        body: theBody,
        icon: theIcon,
        tag: theUrl
    };

    var n = new Notification(theTitle, options);

    var theTimeout = setTimeout(n.close.bind(n), 50000);

    n.addEventListener('click', function () {
        clearTimeout(theTimeout);
        window.open(theUrl);
        n.close();
    });
}

function tsh_spawnNotification(theTitle, theBody) {
    var theIcon = '/Media/Image/Icons/notification-115x115.png';

    theIcon = '/Media/Image/_Notifications/Pets/mable.jpg';

    var options = {
        body: theBody,
        icon: theIcon
    }
    var n = new Notification(theTitle, options);
}
