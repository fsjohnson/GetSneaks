
var cmsFBWentInToLoginStatus = false;
var cms_facebookDebug = false;

function cmsHeaderSignOutOnClick() {
    if (!confirm('Sign out?')) return false;

    var fbToken = cmsGetCookie('fb_token');

    if (cms_me.IsAnonymous) {
        if (!cmsIsNullOrEmpty(fbToken)) {
            FB.api('/me/permissions', 'delete', function (response) {
                if (response == true) {
                    window.location.reload(true);
                }
            });
        }
    }
    else {
        if (!cmsIsNullOrEmpty(fbToken)) {
            FB.api('/me/permissions', 'delete', function (response) {
                if (response == true) {
                    window.location = '/SignOut';
                }
                else {
                    if (response.error.code == 2500) {
                        alert('An error occurred, we could not remove your Facebook permissions.\nIf you close and then reopen your browser and are still signed in, please contact us for assistance.');
                        window.location = '/SignOut';
                    }
                    
                }
            });
        } else {
            window.location = '/SignOut';
        }
    }


}

function cmsButtonFBSignInOnClick(p) {
    
}

function cmsEntitySignOut_FBAuthRevoke() {
    var isFBSignedIn = (cms_me.Custom2 != null && cms_me.Custom2 + '' != '');
    //alert(isFBSignedIn);

    cmsEntitySignOut();

    if (isFBSignedIn) {
        try {
            cmsFBAuthRevoke();
        }
        catch (Error) {
            alert('Error 1 revoking FB authorization.');
        }
    }
}

function cmsFBAuthRevoke() {
    FB.api('/me/permissions', 'delete', function (response) {
        try {
            //console.log(response); // true
        }
        catch(Error)
        {
            alert('Error 2 revoking FB authorization.');
            return;
        }
    });
}

function cmsGetFacebookChannelUrl() {
    cms_facebookChannelUrl = '//' + cmsHttpHost + '/cmx/FBChannel.html';
    return cms_facebookChannelUrl;
}

function cmsCheckFacebookLoginStatus() {
    if (cms_facebookID == '') return;

    cmsGetFacebookChannelUrl();

    FB.getLoginStatus(function (response) {
        cms_facebookStatus = response.status;
        if (cms_facebookStatus == undefined) cms_facebookStatus = '';

        if (cms_facebookStatus === 'connected') {
            // connected
            var fbSignIn = cmsEntityFacebookLogin(response.authResponse.accessToken, response.authResponse.expiresIn);


            /*
            
            if (fbSignIn.HasError) {
                alert('We apologize, an error has occurred preventing us from signing you in:\n' + fbSignIn.StatusText);
                return;
            } else {
                alert('You are signed in with Facebook.');
                if (document.referrer) {
                    window.location = document.referer;
                }
                else {
                    window.location = '/profile';
                }
            }

            */

        } else if (cms_facebookStatus === 'not_authorized') {
            // not_authorized
        } else {
            // not_logged_in
        }
    });
}


function cmsEntityFacebookLogin(token, expires) {
    var cmsEntityFacebookLogin_Return = {};

    var cmsEntityFacebookLogin_Url = '/Ajax/Entity/FacebookLogin?token=' + token + '&expires=' + expires;

    $.ajax({
        url: cmsEntityFacebookLogin_Url,
        cache: false,
        type: 'GET',
        dataType: 'json',
        success: function (json) {
            cmsEntityFacebookLogin_Return = json;
            if (!cmsEntityFacebookLogin_Return.HasError) {
                cmsSetCookie('fb_token', token, null, null, cmsCookieHost, false)
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntityFacebookLogin_Return.HasError = true;
            cmsEntityFacebookLogin_Return.StatusCode = 'ERR_AJAX';
            cmsEntityFacebookLogin_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        },
        complete: function () {
            if (cmsEntityFacebookLogin_Return.HasError) {
                alert('We apologize, an error has occurred preventing us from signing you in:\n' + cmsEntityFacebookLogin_Return.StatusText);
                return;
            } else {
                alert('You are signed in with Facebook.');
                if (document.referrer) {
                    window.location = document.referer;
                }
                else {
                    window.location = '/profile';
                }
            }
        }
    });

    return cmsEntityFacebookLogin_Return;
}

function cmsFacebookSniffForConnected() {
    if (cms_me.IsAnonymous) {
        FB.getLoginStatus(function (response) {
            if (response.authResponse) {
                if (response.authResponse.accessToken) {
                    if (cmsFacebookSniffForConnectedAfterConnect()) {

                        if (cms_template == 'HolidayHome' || cms_template == 'Home') return;

                        if (window.location.pathname == '/SignIn') {
                            window.location = '/';
                        }
                        else {
                            window.location.reload(true);
                        }
                    } else {

                    }
                }
            }
        });
    }
}

function cmsFacebookSniffForConnectedAfterConnect() {
    var cmsAfterFacebookConnectSignIn = {};
    cmsAfterFacebookConnectSignIn.HasError = false;
    cmsAfterFacebookConnectSignIn.StatusCode = '';
    cmsAfterFacebookConnectSignIn.StatusText = '';

    FB.getLoginStatus(function (response) {

        if (response.authResponse.accessToken) {

            cmsAfterFacebookConnectSignIn = cmsEntityFacebookLogin(response.authResponse.accessToken, response.authResponse.expiresIn);

            if (cmsAfterFacebookConnectSignIn.HasError) {
                alert(cmsAfterFacebookConnectSignIn.StatusText);
                return false;
            }

            cms_me = cmsEntityMe();
            return true;
        }
    });

    return !cmsAfterFacebookConnectSignIn.HasError;
}

function cmsFacebookLoginButtonOnClick(pIsFromReveal) {
    FB.login(function (response) {
        if (response.status == 'connected') {

            cmsFacebookLoginButtonAfterConnect();

            if (pIsFromReveal) {
                cmsEntitySignInResetPageElements();
                cmsClearFormElements($('#FormSignIn'));
                $('#cms-formsignin-reveal').foundation('reveal', 'close');
            }
            else
            {
                var returnUrl = '/';

                if (document.referrer) {
                    returnUrl = document.referrer;
                }

                window.location = returnUrl;
            }
        }
        else
        {
            alert('We could not sign you in with Facebook.');
        }
    }, { scope: cmsFBLoginScope } );
}

function cmsFacebookLoginButtonAfterConnect() {
    var cmsAfterFacebookConnectSignIn = {};
    FB.getLoginStatus(function (response) {

        if (response.authResponse.accessToken) {

            /*
            cmsAfterFacebookConnectSignIn = cmsEntityFacebookLogin(response.authResponse.accessToken, response.authResponse.expiresIn);

            if (cmsAfterFacebookConnectSignIn.HasError) {
                alert(cmsAfterFacebookConnectSignIn.StatusText);
                return false;
            }
            */

            var cmsEntityFacebookLogin_Return = {};

            var cmsEntityFacebookLogin_Url = '/Ajax/Entity/FacebookLogin?token=' + response.authResponse.accessToken + '&expires=' + response.authResponse.expiresIn;
            window.open(cmsEntityFacebookLogin_Url);
            return;

            $.ajax({
                url: cmsEntityFacebookLogin_Url,
                cache: false,
                type: 'GET',
                dataType: 'json',
                success: function (json) {
                    cmsEntityFacebookLogin_Return = json;
                    if (!cmsEntityFacebookLogin_Return.HasError) {
                        cmsSetCookie('fb_token', response.authResponse.accessToken, null, null, cmsCookieHost, false)
                    }
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    cmsEntityFacebookLogin_Return.HasError = true;
                    cmsEntityFacebookLogin_Return.StatusCode = 'ERR_AJAX';
                    cmsEntityFacebookLogin_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
                },
                complete: function () {
                    if (cmsEntityFacebookLogin_Return.HasError) {
                        alert('We apologize, an error has occurred preventing us from signing you in:\n' + cmsEntityFacebookLogin_Return.StatusText);
                        return;
                    } else {
                        cms_me = cmsEntityMe();

                        if (0 == 1)
                        {
                            if (cms_me.Created == cms_me.Updated) {
                                if (confirm('You have been signed in with Facebook.\n\nClick OK if you would like to receive our Bideawee Newsletter, otherwise click Cancel.')) {
                                    returnNewsletter = cmsEntityNewsletterToggle('1');
                                } else {
                                    returnNewsletter = cmsEntityNewsletterToggle('0');
                                }
                            }
                        }
                        

                        if (0 == 0 || cms_me.ActionCode == null || cms_me.ActionCode == '') {
                            cmsShowStatus('#cms-StatusCode', 'cms-success', 'You have been signed in with Facebook.');
                            if (document.referrer) {
                                window.location = document.referer;
                            }
                            else {
                                window.location = '/profile';
                            }
                        } else {
                            if (cms_me.ActionCode.indexOf('GO_PROFILE') > -1) {
                                cmsShowStatus('#cms-StatusCode', 'cms-success', 'You have been signed in with Facebook.  Please visit your <a href="/Profile">Profile</a> page to update your information.');
                            }
                        }

                        /*
                        alert('You are signed in with Facebook.');
                        if (document.referrer) {
                            window.location = document.referer;
                        }
                        else {
                            window.location = '/profile';
                        }
                        */
                    }
                }
            });
            
        }
    });
}

function cmsFacebookInitAndSetMe() {
    if (cms_facebookID == '') return;

    cmsGetFacebookChannelUrl();

    window.fbAsyncInit = function () {
        FB.Event.subscribe('auth.authResponseChange', function (response) {
            if (response.status == 'connected') {
                cms_facebookStatus = 'connected';
                cmsFacebookSetMe();
            }
        });

        FB.init({
            appId: cms_facebookID,
            version: 'v2.0',
            status: true,
            cookie: true,
            xfbml: true,
            channelUrl: cms_facebookChannelUrl
        });
    }
}

function cmsFacebookSetMe() {
    if (cms_facebookID == '') return;
    //if (cms_facebookStatus != 'connected') return;

    FB.api('/me', function (response) {
        cms_facebookME = response;
        if (cms_facebookDebug) {
            $('#fb-debug').append('<p>' + JSON.stringify(cms_facebookME) + '</p>');
            //$('#fb-debug').toggle(true);
        }
    });
}

function cmsFacebookGetMe() {
    if (cms_facebookID == '') return "";
    //if (cms_facebookStatus != 'connected') return "";
    var cms_facebookME = {};
    var meReturn = "";

    FB.api('/me', function (response) {
        cms_facebookME = response;
        meReturn = JSON.stringify(cms_facebookME)
    });

    return meReturn;
}


function cmsFacebookPostToUsersFeed(p) {
    var msgMenu = $(p).closest('div.msg-share');

    var obj = {
        method: 'feed',
        display: 'popup',
        redirect_uri: 'http://' + cmsHttpHost + '/cmx/closeWindow.html',
        link: $(msgMenu).find('div.fb-share-url').text(),
        picture: $(msgMenu).find('div.fb-share-url').text(),
        name: $(msgMenu).find('div.fb-share-title').text(),
        caption: $(msgMenu).find('div.fb-share-topic-title').text(),
        description: $(msgMenu).find('div.fb-share-description').text()
    };

    //if (!confirm(obj.name + ': ' + obj.description)) return false;

    FB.ui(
        obj, function (response) {
            if (response && response.post_id) {
                // published
                alert('The item has been posted to your feed.');
                return true;
            } else {
                // not published
                alert('An error occurred, we could not post the item to your feed.');
                return false;
            }
        }
    );

}

/*function cmsFacebookLoadSDK() {
    if (cms_facebookID == '') return;

    if (document.getElementById('fb-root') != undefined) {
        var e = document.createElement('script');
        e.type = 'text/javascript';
        e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
        e.async = true;
        document.getElementById('fb-root').appendChild(e);
    }
}


function cmsFacebookInitAsync() {

    return;


    if (cms_facebookID == '') return;

    cmsGetFacebookChannelUrl();

    window.fbAsyncInit = function () {
        FB.init({
            appId: cms_facebookID,
            status: true,
            cookie: true,
            xfbml: true,
            channelUrl: cms_facebookChannelUrl
        });

        FB.getLoginStatus(function (response) {
            cms_facebookStatus = response.status;
            if (cms_facebookStatus == undefined) cms_facebookStatus = '';
            var sInfo = '';
            var sName = '';


            if (cms_facebookStatus === 'connected') {
                // connected

                FB.api('/me', function (response) {
                    sInfo = 'You are currently signed in with your Facebook account (' + response.name + ').<br /><br />'

                    $('#div-welcome-inner').html(sInfo);
                    $('#div-welcome-outer').toggle(true);
                    
                });

                if (cms_me.IsAnonymous) {

                    var fbSignIn = cmsEntityFacebookLogin(response.authResponse.accessToken);

                    if (fbSignIn.HasError) {
                        alert('We apologize, an error has occurred preventing us from signing you in:\n' + fbSignIn.StatusText);
                        return;
                    } else {
                        window.location.reload(true);
                    }
                } else {
                    $('#div-fb').css('display', 'block');
                }

            } else if (cms_facebookStatus === 'not_authorized') {
                // not_authorized
            } else {
                // not_logged_in
            }
        });
    };

}
*/