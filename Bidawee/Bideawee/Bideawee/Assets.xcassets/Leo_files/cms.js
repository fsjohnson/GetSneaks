
cmsTzOffsetInit();

var defaultFx1Format = 'DD, M d yy'
var cmsItemSaveSplashHtml = null;

$.fn.animateRotate = function (startAngle, endAngle, duration, easing, complete) {
    return this.each(function () {
        var elem = $(this);

        $({ deg: startAngle }).animate({ deg: endAngle }, {
            duration: duration,
            easing: easing,
            step: function (now) {
                elem.css({
                    /*
                    '-moz-transform': 'rotate(' + now + 'deg)',
                    '-webkit-transform': 'rotate(' + now + 'deg)',
                    '-o-transform': 'rotate(' + now + 'deg)',
                    '-ms-transform': 'rotate(' + now + 'deg)',
                    */
                    'transform': 'rotate(' + now + 'deg)'
                });
            },
            complete: complete || $.noop
        });
    });
};



function cmsLandingDropdownMouseClick(p)
{
    $(p).attr('data-mouseclick-activated', '1');

    
}

function cmsLandingDropdownMouseOver(p)
{
    if ($(p).attr('aria-expanded') === 'true') {
        return;
    }

    $(p).click();
    $(p).attr('data-mouseover-activated', '1');
    $(p).attr('data-mouseclick-activated', '0');
}

function cmsLandingDropdownMouseOut(p) {
    if ($(p).attr('aria-expanded') === 'false') {
        return;
    }
    
    if ($(p).attr('data-mouseclick-activated') === '1')
    {
        return;
    }

    if ($(p).attr('data-mouseover-activated') === '1') {
        $(p).click();
        $(p).attr('data-mouseover-activated', '0');
        $(p).attr('data-mouseclick-activated', '0');
    }

}

function cmsCheckSphericalDistance(lat1, long1, lat2, long2)
{
    var url = 'Ajax/Content/CheckSphericalDistance/' + lat1 + '/' + long1 + '/' + lat2 + '/' + long2;
    var val = {};
    val.HasError = false;
    val.StatusText = null;
    val.StatusCode = null;

    $.ajax({
        url: aurl,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            val = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            val.HasError = true;
            val.StatusCode = 'ERR_AJAX';
            val.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        },
        complete: function () {

        }

    });
}


function cmsBodyAnimateScrollTop(y) {
    var t = 0;
    if (y && !isNaN(parseFloat(y))) {
        t = parseFloat(y);
    }

    if (cmsVer < 2.9)
    {
        $("div.off-canvas-wrap").animate({ scrollTop: y }, "slow");
    }
    else
    {
        $("body,html").animate({ scrollTop: y }, "slow");
    }
}

function cmsToggleHamburgerMenu() {
    $('#cms-off-canvas-toggle-menu').click();
}

function cmsIsSmallScreen() {
    return matchMedia(Foundation.media_queries['small']).matches
}

function cmsIsMediumScreen() {
    return matchMedia(Foundation.media_queries['medium']).matches
}

function cmsIsLargeScreen() {
    return matchMedia(Foundation.media_queries['large']).matches
}

function cmsIsXLargeScreen() {
    return matchMedia(Foundation.media_queries['xlarge']).matches
}

function cmsIsXXLargeScreen() {
    return matchMedia(Foundation.media_queries['xxlarge']).matches
}

function cmsFormatAddress(Address1, Address2, City, StateProvince, PostalCode) {
    if(Address1 + Address2 + City + StateProvince + PostalCode + '' == '')
    {
        return '';
    }

    if (Address2 != null) {
        return Address1 + '\n' + Address2 + '\n' + City + ', ' + StateProvince + '  ' + PostalCode;
    }
    else {
        return Address1 + '\n' + City + ', ' + StateProvince + '  ' + PostalCode;
    }

}

function cmsIsInteger(n)
{
    return n % 1 === 0;
}

function cmsIsNumeric(p)
{
    return !isNaN(parseFloat(p));
}

function cmsContentSetTopBarPrimaryContents(p, contentID) {

    var cmsContentSetTopBarPrimaryContents_Return = '';

    var cmsContentSetTopBarPrimaryContents_Url = '/Ajax/Content/_Topbar_Nav_Secondary?id=' + contentID;
    var cmsContentSetTopBarPrimaryContents_HasError = false;
    var cmsContentSetTopBarPrimaryContents_HasItems = true;
    
    $.ajax({
        url: cmsContentSetTopBarPrimaryContents_Url,
        async: true,
        cache: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            cmsContentSetTopBarPrimaryContents_Return = data;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsContentSetTopBarPrimaryContents_Return = '<!-- AJAX_ERROR -->';
            cmsContentSetTopBarPrimaryContents_HasError = true;
        },
        complete: function (data) {
            if (!cmsContentSetTopBarPrimaryContents_HasError) {
                if (cmsContentSetTopBarPrimaryContents_Return.indexOf('<!-- NO_TOPBAR_SECONDARY_NAV_ITEMS -->') >= 0) {
                    cmsContentSetTopBarPrimaryContents_HasItems = false;
                    cmsContentSetTopBarPrimaryContents_Return = '<!-- NO_TOPBAR_SECONDARY_NAV_ITEMS -->';
                    $(p).removeClass('has-dropdown');
                }

                if (cmsContentSetTopBarPrimaryContents_HasItems) {
                    $(p).append(cmsContentSetTopBarPrimaryContents_Return);

                    $(p).find('li.cms-li-secondary').each(function (index) {
                        var tertiaryUL = $(this).find('ul.cms-ul-tertiary');
                        if (tertiaryUL.length == 0) {
                            $(this).removeClass('has-dropdown');
                        }
                        else
                        {
                            $(this).find('li.cms-li-tertiary').each(function (index) {
                                var quarternaryUL = $(this).find('ul.cms-ul-quarternary');
                                if (quarternaryUL.length == 0) {
                                    $(this).removeClass('has-dropdown');
                                }
                                else
                                {
                                    $(this).find('li.cms-li-quarternary').each(function (index) {
                                        var quinaryUL = $(this).find('ul.cms-ul-quinary');
                                        if (quinaryUL.length == 0) {
                                            $(this).removeClass('has-dropdown');
                                        }
                                    });
                                }
                            });

                        }
                    });

                    if (0 == 1)
                    {
                    $(p).find('li.cms-li-secondary:not(.has-dropdown)').find('a.cms-nav-secondary').each(function (index) {
                        var thisText = $(this).text();
                        if (thisText.indexOf('&raquo;') >= 0)
                        {
                            // leave as is
                        }
                        else
                        {
                            $(this).html(thisText + ' &raquo;');
                        }
                    });

                    $(p).find('li.cms-li-tertiary:not(.has-dropdown)').find('a.cms-nav-tertiary').each(function (index) {
                        var thisText = $(this).text();
                        if (thisText.indexOf('&raquo;') >= 0) {
                            // leave as is
                        }
                        else {
                            $(this).html(thisText + ' &raquo;');
                        }
                    });
                    }

                    $(document).foundation('topbar', 'reflow');
                    cmsContentSetTopBarPrimaryContents_Return = '<!-- TOPBAR_SECONDARY_NAV_ITEMS_SET -->';
                }
            }
        }
    });

    return cmsContentSetTopBarPrimaryContents_Return;

    
}

function cmsFormSignInOnSubmit() {

    var form = $('#FormSignIn');
    var formMode = 'page';
    if ($(form).attr('data-form-mode') == 'reveal') {
        formMode = 'reveal';
    }

    if (formMode == 'page')
    {
        $('#form-content-signin1-wrapper').children('div').css('visibility', 'hidden');
        $('#form-content-signin1-wrapper').css('background-color', '#ccc');
        $('#form-content-signin1-wrapper').css('opacity', '0.5');
    }

    $.ajax({
        url: '/Ajax/FormSignIn',
        type: "POST",
        data: form.serialize(),

        success: function (data) {
            var status = data;

            // alert(status.StatusText);

            if (status.HasWarning) {
                
                cmsShowStatus('#cms-' + formMode + '-StatusCode', 'cms-warning', status.StatusText);

            } else if (status.HasError) {
                cmsShowStatus('#cms-' + formMode + '-StatusCode', 'cms-error', status.StatusText);

            } else {

                cmsShowStatus('#cms-' + formMode + '-StatusCode', 'cms-success', status.StatusText);

                if ($('#form-signin-ui-redirect').text() != '') {
                    window.location = $('#form-signin-ui-redirect').text();
                    return;
                }

                if (cms_template == 'FormAlumniRewards' || cms_template == "FormProfile" || cms_template == "FormProfileMini")
                {
                    window.location.reload(true);
                    return;
                }


                var returnUrl = '/';

                if (document.referrer) {
                    
                    if (document.referrer.toLowerCase() == (cms_protocol + '://' + cms_host + '/SignOut').toLowerCase())
                    {
                        returnUrl = '/';
                    }
                    else
                    {
                        if ((cms_protocol + '://' + cms_host + cms_rawurl).toLowerCase() != document.referrer.toLowerCase()) {
                            returnUrl = document.referrer;
                        }
                    }
                    
                }

                if (returnUrl != '/') {
                    if (status.StatusText != '') {
                        $('#cms-' + formMode + '-StatusCode').html(status.StatusText + ' <a href="' + returnUrl + '" style="color:white;text-decoration:underline;">Return to previous page.</a>');
                    } else {
                        $('#cms-' + formMode + '-StatusCode').html('You have been signed in. ' + ' <a href="' + returnUrl + '" style="color:white;text-decoration:underline;">Return to previous page.</a>');
                    }
                }
                else {
                    if (status.StatusText != '') {
                        $('#cms-' + formMode + '-StatusCode').html(status.StatusText);
                    } else {
                        $('#cms-' + formMode + '-StatusCode').html('You have been signed in .');
                    }
                }


                cmsEntitySignInResetPageElements();
                cmsClearFormElements($('#FormSignIn'));

                

                if (formMode == 'reveal') {
                    $('#cms-formsignin-reveal').foundation('reveal', 'close');
                }
                else
                {
                    $('#FormSubscribe-Row-Body').toggle(false);
                    $('#FormSubscribe-Row-Headline').toggle(true);
                    window.location = returnUrl;
                }
            }
        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

            if (formMode != 'reveal') {

                $('#form-content-signin1-wrapper').children('div').css('visibility', 'visible');
                $('#form-content-signin1-wrapper').css('background-color', '');
                $('#form-content-signin1-wrapper').css('opacity', '');

                cmsBodyAnimateScrollTop(0);
            }

            //$("#ProgressDialog").dialog("close");
        }
    });
}

function cmsAfterSignInCallConvio() {
    var request = createCORSRequest("get", cmsEntitySingleSignOnUrl);
    if (request) {
        // Define a callback function
        request.onload = function () { };
        // Send request
        request.send();
    }
}

function createCORSRequest(method, url) {
    var xhr = new XMLHttpRequest();
    if ("withCredentials" in xhr) {
        // XHR has 'withCredentials' property only if it supports CORS
        xhr.open(method, url, true);
    } else if (typeof XDomainRequest != "undefined") { // if IE use XDR
        xhr = new XDomainRequest();
        xhr.open(method, url);
    } else {
        xhr = null;
    }
    return xhr;
}

function cmsFormSignInExtdRevealSuccessful() {
    cmsEntitySignInResetPageElements();
    $('#cms-formsignin-reveal').foundation('reveal', 'close');
}

function cmsIsNullOrEmpty(p) {
    if (p == null) return true;
    if (p == '') return true;
    if ($.trim(p) == '') return true;
    return false;
}

function cmsSignInOffCanvasNav() {
    window.location = '/SignIn';
    return;

    $('#a-cms-formsignin-reveal').click();
    /*
    $('#cms-formsignin-reveal').foundation('reveal', 'open', {
        url: $('#a-cms-formsignin-reveal').attr('href'),
        success: function (data) {
            $(document).foundation();
        }
    });
    */

    //$(document).foundation();
}

function cmsSignOutOffCanvasNav() {
    if (!confirm('Are you sure you want to sign out?')) {
        return false;
    }

    cmsRemoveSignInCookies();
    cmsEntitySignInResetPageElements();

    try {
        cmsFBAuthRevoke();
    }
    catch (Error) {
        alert('Error 1 revoking FB authorization.');
    }
    window.location = '/SignOut';

    //$('.off-canvas-wrap').foundation('offcanvas', 'toggle', 'move-right');
}

function cmsEntitySignInResetPageElements() {
    var me = cmsEntityMe();
   
}

function cmsSetNavSignInSignOut() {
    var me = cmsEntityMe();
    
}

function cmsSetNavSignInSignOut2(isAnonymous) {
    if (isAnonymous) {
        $('#a-cms-signout').toggle(false);
        $('#a-cms-profile').toggle(false);
        $('#a-cms-signin').toggle(true);
        $('#a-cms-signup').toggle(true);

        $('#a-cms-signout-top').css('display', 'none');
        $('#a-cms-profile-top').css('display', 'none');
        $('#a-cms-signin-top').css('display', 'inline');
        $('#a-cms-signup-top').css('display', 'inline');


        $('#a-cms-signout-bottom').css('display', 'none');
        $('#a-cms-profile-bottom').css('display', 'none');
        $('#a-cms-signin-bottom').css('display', 'block');
        $('#a-cms-signup-bottom').css('display', 'block');

    }
    else {
        $('#a-cms-signout').toggle(true);
        $('#a-cms-profile').toggle(true);
        $('#a-cms-signin').toggle(false);
        $('#a-cms-signup').toggle(false);

        $('#a-cms-signout-top').css('display', 'inline');
        $('#a-cms-profile-top').css('display', 'inline');
        $('#a-cms-signin-top').css('display', 'none');
        $('#a-cms-signup-top').css('display', 'none');


        $('#a-cms-signout-bottom').css('display', 'block');
        $('#a-cms-profile-bottom').css('display', 'block');
        $('#a-cms-signin-bottom').css('display', 'none');
        $('#a-cms-signup-bottom').css('display', 'none');
    }

}

function cmsEntityMe() {
    var cmsEntityMe_Return = {};

    var cmsEntityMe_Url = '/Ajax/Entity/Me';

    $.ajax({
        url: cmsEntityMe_Url,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            cmsEntityMe_Return = json;
            cms_me = cmsEntityMe_Return;
            var me = cms_me;

            if (!me.IsAnonymous) {
                $('div.my-profile-signin-wrapper').toggle(false);
                $('a.my-profile-image-link').attr('href', '/Profile');
                $('a.my-profile-image-link').attr('target', '');

                if (me.Custom2 + '' != '') {
                    $('img.my-profile-image').attr('src', 'https://graph.facebook.com/' + me.Custom2 + '/picture');
                }

                $('div.my-profile-info').text(me.Name);
                $('#Msg_Body').attr('placeholder', 'Enter comment');
                $('div.msg-content-series-sidebar-create-submit').attr('visibility', 'visible');

                $('a.msg-content-series-sidebar-like-link').attr('onclick', 'cmsMsgContentSeriesSidebarLikeItem(this);return false;');
                $('div.my-profile-wrapper').toggle(true);
                $('div.msg-content-series-sidebar-create-form').toggle(true);

                //in _Forum_Subjects
                $('div.msg-forum-subject-create-profile-img a').attr('href', '/Profile');
                $('div.msg-forum-subject-create-profile-img a').attr('title', 'Edit your profile');
                $('div.msg-forum-subject-create-profile-img img').attr('alt', 'Edit your profile');
                if (me.Custom2 + '' != '') {
                    $('div.msg-forum-subject-create-profile-img img').attr('src', 'https://graph.facebook.com/' + me.Custom2 + '/picture');
                }

                $('div.msg-forum-subject-create-profile a').toggle(false);
                $('div.msg-forum-subject-create-profile span').text(me.FullName);
                $('div.msg-forum-subject-create-profile span').toggle(true);
                $('#Msg_Forum_Subjects_Title').attr('placeholder', 'Enter new Title (400 characters max)'); //Sign in to create new Topic
                $('#Msg_Forum_Subjects_Body').attr('placeholder', 'Enter new Message (4000 characters max)');

                //FormAlumniRewards
                $('#div-prompt-signin').toggle(false);
                $('#FormAlumniRewards').toggle(true);

                $('#adoption_AdopterFirstName').val(me.FirstName);
                $('#adoption_AdopterLastName').val(me.LastName);
                $('#adoption_AdopterEmail').val(me.Email);

                $('#me_FirstName').val(me.FirstName);
                $('#me_LastName').val(me.LastName);
                $('#me_Email').val(me.Email);
                $('#me_Phone').val(me.Phone);
                $('#me_Address1').val(me.Address1);
                $('#me_Address2').val(me.Address2);
                $('#me_City').val(me.City);
                $('#me_StateProvince').val(me.StateProvince);
                $('#me_CountryCode').val(me.CountryCode);
            }
            else {
                $('div.my-profile-signin-wrapper').toggle(true);
                $('a.my-profile-image-link').attr('href', '');
                $('a.my-profile-image-link').attr('target', '');
                $('img.my-profile-image').attr('src', '');

                $('div.my-profile-info').text('');
                $('#Msg_Body').attr('placeholder', 'Sign in to comment');
                $('div.msg-content-series-sidebar-create-submit').attr('visibility', 'hidden');

                $('a.msg-content-series-sidebar-like-link').attr('onclick', 'alert("Sign-in to like this comment.");return false;');
                $('div.my-profile-wrapper').toggle(false);
                $('div.msg-content-series-sidebar-create-form').toggle(false);

                //FormAlumniRewards
                $('#div-prompt-signin').toggle(true);

                $('#FormAlumniRewards').toggle(false);


                $('#adoption_AdopterFirstName').val('');
                $('#adoption_AdopterLastName').val('');
                $('#adoption_AdopterEmail').val('');

                if ($('#FormAlumniRewards').length > 0) {
                    window.location.reload(true);

                }
            }

            cmsSetNavSignInSignOut2(me.IsAnonymous)

        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntityMe_Return.HasError = true;
            cmsEntityMe_Return.StatusCode = 'ERR_AJAX';
            cmsEntityMe_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    return cmsEntityMe_Return;
}

function cmsEntityNewsletterToggle(custom1) {
    var cmsEntityNewsletterToggle_Return = {};

    var cmsEntityNewsletterToggle_Url = '/Ajax/Entity/Newsletter_Toggle?Entity.Custom1=' + custom1;

    $.ajax({
        url: cmsEntityNewsletterToggle_Url,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            cmsEntityNewsletterToggle_Return = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntityNewsletterToggle_Return.HasError = true;
            cmsEntityNewsletterToggle_Return.StatusCode = 'ERR_AJAX';
            cmsEntityNewsletterToggle_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    return cmsEntityNewsletterToggle_Return;
}

function cmsEntityNotificationsToggleLinkClick(p)
{
    var xreturn = cmsEntityNotificationsToggle();
    if (xreturn.HasError)
    {
        alert(xreturn.StatusText);
        return;
    }

    if (cms_me.SocialOption == 2 || cms_me.SocialOption == 3)
    {
        $(p).text('Notifications are on');
    }
    else
    {
        $(p).text('Notifications are off');
    }
}

function cmsEntityNotificationsToggle() {
    var cmsEntityNotificationsToggle_Return = {};
    var cmsEntityNotificationsToggle_Url = '/Ajax/Entity/Notifications_Toggle?Entity.Notifications=';

    if ((cms_me.SocialOption & 2) == 2)
    {
        cmsEntityNotificationsToggle_Url = cmsEntityNotificationsToggle_Url + '0';
        cms_me.SocialOption = (cms_me.SocialOption ^ 2);
    }
    else
    {
        cmsEntityNotificationsToggle_Url = cmsEntityNotificationsToggle_Url + '1';
        cms_me.SocialOption = (cms_me.SocialOption | 2);
    }

    $.ajax({
        url: cmsEntityNotificationsToggle_Url,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            cmsEntityNotificationsToggle_Return = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntityNotificationsToggle_Return.HasError = true;
            cmsEntityNotificationsToggle_Return.StatusCode = 'ERR_AJAX';
            cmsEntityNotificationsToggle_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    
    return cmsEntityNotificationsToggle_Return;
}

function cmsEntitySignOut() {
    cmsRemoveSignInCookies();
    cms_me = cmsEntityMe();
}

function cmsEntitySignIn(name, password) {
    var cmsEntitySignIn_Return = {};

    var cmsEntitySignIn_Url = '/Ajax/Entity/SignIn?Entity.Name=' + name + '&Entity.Password=' + password;

    $.ajax({
        url: cmsEntitySignIn_Url,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            cmsEntitySignIn_Return = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntitySignIn_Return.HasError = true;
            cmsEntitySignIn_Return.StatusCode = 'ERR_AJAX';
            cmsEntitySignIn_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    if (!cmsEntitySignIn_Return.HasError) {
        cmsSetSignInCookies(cmsEntitySignIn_Return);
    }

    return cmsEntitySignIn_Return;
}

function cmsEntityFacebookLoginX(token) {
    var cmsEntityFacebookLogin_Return = {};

    var cmsEntityFacebookLogin_Url = '/Ajax/Entity/FacebookLogin?token=' + token;
    //alert('Token = ' + token);

    $.ajax({
        url: cmsEntityFacebookLogin_Url,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'json',
        success: function (json) {
            cmsEntityFacebookLogin_Return = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntityFacebookLogin_Return.HasError = true;
            cmsEntityFacebookLogin_Return.StatusCode = 'ERR_AJAX';
            cmsEntityFacebookLogin_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    return cmsEntityFacebookLogin_Return;
}

function cmsShowProgressDialog() {
    // move to top
    return;
    $('#cms-progress').css('display', 'block');
    $('#cms-progress').focus();
    return;
}

function cmsHideProgressDialog() {
    return;
    $('#cms-progress').css('display', 'none');
    return;
}

function cmsMainScrollPaneInit() {
    // v4.0 mod main
    return;
   cms_mainScrollPane = $('#main').jScrollPane({ showArrows: true });
   cms_mainScrollPaneAPI = cms_mainScrollPane.data('jsp');
}


function cmsMainScrollPaneReInit() {
    // v4.0 mod main
    return;

    if (cms_mainScrollPaneAPI == null) {
        cmsMainScrollPaneInit('#main');
    }

    cms_mainScrollPaneAPI.reinitialise();
}

function cmsMainScrollPaneToTop() {
    // v4.0 mod main
    $('html').scrollTop(0);
    return;

    
    if (cms_mainScrollPaneAPI == null) {
        cmsMainScrollPaneInit('#main');
    }

    cms_mainScrollPaneAPI.scrollTo(0, 0);
}

function cmsShowStatus(pSelector, pClass, pText) {
    $(pSelector).removeClass('cms-success');
    $(pSelector).removeClass('cms-warning');
    $(pSelector).removeClass('cms-error');
    $(pSelector).addClass(pClass);
    $(pSelector).html(pText);
    if (pSelector == '#cms-StatusCode') {
        $(pSelector).fadeIn(1000, function () { cmsMainScrollPaneToTop(); });
        $(pSelector).css('display', 'block');
    }
    else {
        $(pSelector).css('display', 'block');
    }
   
    
}

function cmsHideStatus(pSelector) {
    $(pSelector).removeClass('cms-success');
    $(pSelector).removeClass('cms-warning');
    $(pSelector).removeClass('cms-error');
    $(pSelector).addClass('cms-success');
    //$(pSelector).css('display', 'none');
    $(pSelector).fadeOut(1000);
    $(pSelector).html('');
}

function cmsGlobalSearchField_Click() {
    var fieldVal = $('#globalsearchfield').val();
    
    if( fieldVal == $('#globalsearchfield').attr('data-cms-default') ) {
        $('#globalsearchfield').val('')
    }
}


function cmsGoGlobalSearch() {
    var fieldVal = $('#globalsearchfield').val();
    if (fieldVal + '' == '') {
        alert('Please enter a word or words to search.');
        return false;
    }

    window.location = '/Search?search=' + escape(fieldVal);
}

function cmsContent_SaveVote(contentID) {
    var Content_SaveVoteReturn = {};

    var cmsContent_SaveVoteUrl = '/Ajax/Content/SaveVote/' + contentID;
    $.ajax({
        url: cmsContent_SaveVoteUrl,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            Content_SaveVoteReturn = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            Content_SaveVoteReturn.HasError = true;
            Content_SaveVoteReturn.StatusCode = 'ERR_AJAX';
            Content_SaveVoteReturn.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    return Content_SaveVoteReturn;
}

function cmsEntitySingleSignIn(auth_token) {
    var EntitySingleSignInReturn = {};

    var cmsEntitySingleSignInUrl = cmsEntitySingleSignOnUrl + auth_token;
    //alert('cmsEntitySingleSignInUrl = ' + cmsEntitySingleSignInUrl);

    $.ajax({
        url: cmsEntitySingleSignInUrl,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            EntitySingleSignInReturn = json;
            alert('Success = ' + json);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert('An error occurred: ' + xhr + ', ' + thrownError);
            return xhr + ', ' + thrownError;
        }
    });

    return '';
}

function cmsInjectTestAnswers(pForm) {
    $('#' + pForm + ' input[type="text"]').val('Test String Injected');
    $('#' + pForm + ' textarea').val('Test String Injected\nLine #2');
    $('#' + pForm + ' input[type="radio"]').attr('checked',true);
}

function cmsCopyFieldByNum(pBase,p1,p2) {
    $('#' + pBase + p2).val($('#' + pBase + p1).val());
}

function cmsRenderPetPointDetail(animalID) {
    var petDetailHtml2 = cmsGetPetDetail(animalID);
    $('#cms-lightbox-inner').html(petDetailHtml2);

    cmsPetPointDetailSetExpander();
    /*$("#petpoint-detail-photo-main").draggable({ revert: true });*/
    $('#a-cms-lightbox').click();
}

function cmsPetPointDetailSetExpander() {
    $('#petpoint-detail-desc p').expander({
        slicePoint: 200,  // default is 100
        expandPrefix: ' ', // default is '... '
        expandText: '[...]', // default is 'read more'
        collapseTimer: 0, // 320000 re-collapses after 320 seconds; default is 0, so no re-collapsing
        userCollapseText: '[^]'  // default is 'read less'
    });
}

function cmsGetPetDetail(animalID) {
    var petDetailHtml = '<!-- not loaded -->';
    var sGetPetDetailUrl = '/Ajax/PetDetail/' + animalID;

    var request = $.ajax({
        url: sGetPetDetailUrl,
        async: false,
        type: 'POST',
        dataType: 'html',
        success: function (data) {
            petDetailHtml = data;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            petDetailHtml = '\n<div class="cms-error">Error loading content for ' + sGetPetDetailUrl + '<br /><br />' + xhr.status + '</div>\n';
            alert(sGetPetDetailUrl + ': ' + xhr.status + ', ' + thrownError);
        }
    });

    return petDetailHtml;
}

function cmsContentHasScored(topicID, panel) {

    var cmsContentHasScored_Return = cmsContentScore(topicID, panel);
    if (cmsContentHasScored_Return.HasError) {
        alert('Error: ' + cmsContentHasScored_Return.StatusText);
        return false;
    }

    return (cmsContentHasScored_Return.TopicValue + '' != '');
}

function cmsContentMyScore(topicID, panel) {

    var cmsContentMyScore_Return = cmsContentScore(topic, topicID, panel);

    return cmsContentMyScore_Return.TopicValue;
}

function cmsContentScore(topicID, panel) {

    var cmsContentScore_Return = {};

    var cmsContentScore_Url = '/Ajax/Content/Score?topicID=' + topicID + '&panel=' + panel;

    $.ajax({
        url: cmsContentScore_Url,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            cmsContentScore_Return = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsContentScore_Return.HasError = true;
            cmsContentScore_Return.StatusCode = 'ERR_AJAX';
            cmsContentScore_Return.StatusText = xhr.status;
            cmsContentScore_Return.TopicValue = '';
            cmsContentScore_Return.Topic = 'Content';
            cmsContentScore_Return.TopicID = topicID;
        }
    });

    return cmsContentScore_Return;
}


function cmsEntityHasScored(topic, topicID, panel) {

    var cmsEntityHasScored_Return = cmsEntityScore(topic, topicID, panel);
    if (cmsEntityHasScored_Return.HasError) {
        alert('Error: ' + cmsEntityHasScored_Return.StatusText);
        return false;
    }

    return (cmsEntityHasScored_Return.TopicValue + '' != '');
}

function cmsEntityMyScore(topic, topicID, panel) {

    var cmsEntityMyScore_Return = cmsEntityScore(topic, topicID, panel);

    return cmsEntityMyScore_Return.TopicValue;
}

function cmsEntityScore(topic, topicID, panel) {

    var cmsEntityScore_Return = {};

    var cmsEntityScore_Url = '/Ajax/Entity/MyScore?topic=' + topic + '&topicID=' + topicID + '&panel=' + panel;

    $.ajax({
        url: cmsEntityScore_Url,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            cmsEntityScore_Return = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntityScore_Return.HasError = true;
            cmsEntityScore_Return.StatusCode = 'ERR_AJAX';
            cmsEntityScore_Return.StatusText = xhr.status;
            cmsEntityScore_Return.TopicValue = '';
            cmsEntityScore_Return.Topic = topic;
            cmsEntityScore_Return.TopicID = topicID;
        }
    });

    return cmsEntityScore_Return;
}

function cmsEntityCheckValue(field, newValue) {

    var cmsEntityCheckValueReturn = {};

    var cmsEntityCheckValueUrl = '/Ajax/Entity/CheckValue?field=' + field + '&newValue=' + newValue;

    $.ajax({
        url: cmsEntityCheckValueUrl,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            cmsEntityCheckValueReturn = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsEntityCheckValueReturn.HasError = true;
            cmsEntityCheckValueReturn.StatusCode = 'ERR_AJAX';
            cmsEntityCheckValueReturn.StatusText = xhr.status;

            alert(xhr + ', ' + thrownError);
        }
    });

    if (cmsEntityCheckValueReturn.HasError) {
        // non-empty means error
        return cmsEntityCheckValueReturn.StatusText;
    }

    return '';
}

function cmsFlipPetPointDetailPhoto(p) {
    var petID = $(p).attr('data-id');
    var selector = '#petpoint-detail-photo-main-' + petID;
    $(selector).fadeOut('slow', function () {
        $(selector).attr('src', $(p).attr('src'));
        $(selector).fadeIn('slow');
    });
}

function cmsToggleAutoAuthMainOverflow(p) {
    var cms_main_height = '450px';

    if (cms_main_height == '') {
        cms_main_height = $('#main').css('height');
    }

    if ($('#main').css('overflow') == 'auto') {
        $('#main').css('height', 'auto');
        $('#main').css('overflow', 'visible');
        $(p).html('Collapse');
    } else {
        $('#main').css('height', cms_main_height);
        $('#main').css('overflow', 'auto');
        $(p).html('Expand');
    }
}

function cmsToggleMainOverflow(p) {
    if(cms_main_height == '')
    {
        cms_main_height = $('#main').css('height');
    }

    if ($('#main').css('overflow') == 'auto') {
        $('#main').css('height', 'auto');
        $('#main').css('overflow', 'visible');
        $(p).html('Collapse');
    } else {
        $('#main').css('height', cms_main_height);
        $('#main').css('overflow', 'auto');
        $(p).html('Expand');
    }
}

function cmsToggleFieldsetTable(tbl) {
    if ($('#' + tbl).css('display') == 'none') {
        $('#' + tbl).css('display', 'block');
    }
    else {
        $('#' + tbl).css('display', 'none');
    }
}

function cmsToggleFieldsetTable2(p, tbl) {
    if (p.checked) {
        $('#' + tbl).css('display', 'block');
    }
    else {
        $('#' + tbl).css('display', 'none');
    }
}


function cmsShowError() {
    $('div.cms-error').css('display', 'block');
    $('div.cms-success').css('display', 'none');
    $('div.cms-warning').css('display', 'none');
}

function cmsShowSuccess() {
    $('div.cms-error').css('display', 'none');
    $('div.cms-success').css('display', 'block');
    $('div.cms-warning').css('display', 'none');
}

function cmsShowWarning() {
    $('div.cms-error').css('display', 'none');
    $('div.cms-success').css('display', 'none');
    $('div.cms-warning').css('display', 'block');
}

function cmsGetPageSection(url) {
    var sectionHtml = '<!-- not loaded -->';
    var sGetPageSectionUrl = '/Ajax/Section/' + url;

    var request = $.ajax({
        url: sGetPageSectionUrl,
        async: false,
        type: 'POST',
        dataType: 'html',
        cache: false,
        success: function (data) {
            //alert(data);
            sectionHtml = data;
        },
        error:function (xhr, ajaxOptions, thrownError){
            sectionHtml = sectionHtml + '\n<div class="cms-error">Error loading content for ' + sGetPageSectionUrl + '<br /><br />' + xhr.status + '</div>\n';
            //alert(xhr.status);
            //alert(thrownError);
        }   
    });

    return sectionHtml;
}

function cmsClearFormElements(ele) {

    $(ele).find(':input').each(function () {
        switch (this.type) {
            case 'password':
            case 'select-multiple':
            case 'select-one':
            case 'text':
            case 'textarea':
                $(this).val('');
                break;
            case 'checkbox':
            case 'radio':
                this.checked = false;
        }
    });

}

function cmsGetContentByID(cid) {
    var content = {};

    $.ajax({
        url: '/Ajax/ID/' + cid,
        async: false,
        dataType: 'json',
        success: function (json) {
            content = json;
        }
    });

    return content;
}

function cmsGetContentByUrl(url) {
    var content = {};

    $.ajax({
        url: '/Ajax/URL/' + url,
        async: false,
        dataType: 'json',
        success: function (json) {
            content = json;
        }
    });

    return content;
}

function cmsSetDetailAndSidebarActive(currentUrl, primaryUrl, secondaryUrl) {
    cmsSetDetailMenuActive(primaryUrl);
    cmsSetSidebarActive(currentUrl, primaryUrl, secondaryUrl);
}

function cmsSetDetailMenuActive(primaryUrl) {
    $('nav.detail div[data-cms-primary-menu = "detail"]').removeClass('w100-active');
    $('nav.detail div[data-cms-primary-menu = "detail"]').removeClass('w150-active');
    $('nav.detail div[data-cms-primary-menu = "detail"]').removeClass('w200-active');
    $('nav.detail div[data-cms-primary-menu = "detail"]').removeClass('w248-active');

    var navItem = $('nav.detail div[data-cms-primary-url = "' + primaryUrl + '"]');

    if (navItem == null) {
        return;
    }
    
    var baseClass = $('nav.detail div[data-cms-primary-url = "' + primaryUrl + '"]').attr('data-cms-primary-class');

    navItem.addClass(baseClass + '-active');
    
}

function cmsSetSidebarActive(currentUrl, primaryUrl, secondaryUrl) {
    var cmsSetSidebarActive_Debug = 0;
    var exitSub = false;
    var cmsID;
    var cmsURL;
    var sidebarDiv;
    var sidebarDivChildren;
    var sidebarActiveSet = false;
    var highlighted = "";

    //clear all for any active state
    $('#sidebar-accordion').children('h3.sidebar-item-header').removeClass('ui-state-active');
    $('#sidebar-accordion').children('h3.sidebar-item-header').removeClass('ui-highlighted-state-active');
    $('#sidebar-accordion').children('h3.sidebar-item-header').addClass('ui-state-default');

    $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
        highlighted = $(this).attr('data-cms-css');
        if (highlighted == 'highlighted') {
            $(this).addClass('ui-highlighted-state-default');
        }
    });

    // hide arrow
    $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
        cmsID = $(this).attr('data-cms-id');
        sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');
        sidebarDivChildren = sidebarDiv.children();
        $(this).attr('data-cms-child-count', sidebarDivChildren.length);
        highlighted = $(this).attr('data-cms-css');

        if (sidebarDivChildren.length == 0) {
            if (highlighted == 'highlighted') {
                $(this).css('background-image', 'url("/Content/img/ui/bg-sidebar-item-highlighted-noarrow.png")');
            }
            else {
                $(this).css('background-image', 'url("/Content/img/ui/bg-sidebar-item-noarrow.png")');
            }

        }
    });

    // we're on primary page -- find first item with content and open it
    if (cms_enumtype == 101) {
        if (0 == 1) {
            $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

                if (exitSub) { return; }

                cmsID = $(this).attr('data-cms-id');
                cmsURL = $(this).attr('data-cms-url');

                sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

                if ($(this).attr('data-cms-child-count') > 0) {
                    $(sidebarDiv).css('display', 'block');
                    exitSub = true;
                }

            });
        }
    }
    else if (cms_enumtype == 102) {
        //alert(102);
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-url') == cms_secondary_url) {
                    $(sidebarDiv).css('display', 'block');
                    exitSub = true;
                }

            }
        });
    }
    else if (cms_enumtype == 103) {
        //alert(103);
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-secondary-url') == cms_secondary_url) {
                    if ($(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_url + '"]').length > 0) {
                        $(sidebarDiv).css('display', 'block');
                        $(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_url + '"]').css('font-weight', 'bold');
                        exitSub = true;
                    }

                }
            }

        });
    } else {
        if (0 == 1) {
            $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

                if (exitSub) { return; }

                cmsID = $(this).attr('data-cms-id');
                cmsURL = $(this).attr('data-cms-url');

                sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

                if ($(this).attr('data-cms-child-count') > 0) {
                    if ($(this).attr('data-cms-url') == cms_url) {
                        $(sidebarDiv).css('display', 'block');
                        exitSub = true;
                    }
                }

            });
        }
    }
}


function cmsSetSidebarActiveOLD(currentUrl, primaryUrl, secondaryUrl) {
    var cmsSetSidebarActive_Debug = 0;
    $('#sidebar-accordion h3.sidebar-item-header').removeClass('ui-state-active').addClass('ui-state-default');
    /*$('#sidebar-accordion h3.sidebar-item-header').removeClass('ui-state-active');
    $('#sidebar-accordion h3.sidebar-item-header').addClass('ui-state-default');
    */

    if ($('#sidebar-accordion h3[data-secondary-url = "' + secondaryUrl + '"]')) {
        if (cmsSetSidebarActive_Debug == 1) { alert('secondary'); }
        
        if (cms_enumtype == 101) {
            $('#sidebar-accordion div.sidebar-item-main').css('display', 'none');
        }
        else {
            $('#sidebar-accordion h3[data-cms-secondary-url = "' + secondaryUrl + '"]:first').addClass('ui-state-active');
            $('#sidebar-accordion div.sidebar-item-main[data-cms-secondary-url = "' + secondaryUrl + '"]').show();
        }
    } else if ($('#sidebar-accordion h3[data-cms-primary-url = "' + primaryUrl + '"]')) {
        if (cmsSetSidebarActive_Debug == 1) { alert('primary'); }
       
        if (cms_enumtype == 101) {
            $('#sidebar-accordion div.sidebar-item-main').css('display', 'none');
        }
        else {
            $('#sidebar-accordion h3[data-cms-primary-url = "' + primaryUrl + '"]:first').addClass('ui-state-active');
            $('#sidebar-accordion div.sidebar-item-main[data-cms-primary-url = "' + primaryUrl + '"]').show();
        }
    } else if ($('#sidebar-accordion h3[data-cms-url = "' + currentUrl + '"]')) {
        if (cmsSetSidebarActive_Debug == 1) { alert('top'); }
        
        if (cms_enumtype == 101) {
            $('#sidebar-accordion div.sidebar-item-main').css('display', 'none');
        }
        else {
            $('#sidebar-accordion div.sidebar-item-main[data-cms-url = "' + currentUrl + '"]').show();
            $('#sidebar-accordion h3[data-cms-url = "' + currentUrl + '"]:first').addClass('ui-state-active');
        }
    }
}



function cmsTzOffsetInit() {
    //alert(cmsTzCalcOffset());
    var s = getCookieValue('cmsTzOffset');
    if (s == null || s == '') {
        cmsTzOffsetSetCookie();
    }
}

function cmsTzOffsetSetCookie() {
    var oHours = cmsTzCalcOffset();
    document.cookie = 'cmsTzOffset=' + oHours.toString();
    //alert(getCookieValue('cmsTzOffset'));
}

function cmsTzCalcOffset() {
    var d = new Date();
    var oMinutes = d.getTimezoneOffset();
    var oHours = -1 * (oMinutes / 60);
    return oHours;
}

function getCookieValue(key) {
    currentcookie = document.cookie;
    if (currentcookie.length > 0) {
        firstidx = currentcookie.indexOf(key + "=");
        if (firstidx != -1) {
            firstidx = firstidx + key.length + 1;
            lastidx = currentcookie.indexOf(";", firstidx);
            if (lastidx == -1) {
                lastidx = currentcookie.length;
            }
            return unescape(currentcookie.substring(firstidx, lastidx));
        }
    }
    return "";
}

function cmsRemoveSignInCookies() {
    //name, value, expires, path, domain, secure
    cmsSetCookie('cms.Models.Entity.ID', '', -1, cmsCookieHost, false);
    cmsSetCookie('cms.Models.Entity.SignIn', '', -1, cmsCookieHost, false);
    cmsSetCookie('cms.Models.Entity.FullName', '', -1, cmsCookieHost, false);
    cmsSetCookie('cms.Models.Entity.ActionCode', '', -1, cmsCookieHost, false);
    cmsSetCookie('cms.Models.Entity.Custom2', '', -1, cmsCookieHost, false);
    cmsSetCookie('cms.Models.Entity.Custom.Pet', '', -1, cmsCookieHost, false);
    cmsSetCookie('fb_token', '', -1, cmsCookieHost, false);
    
}

function cmsSetSignInCookies(new_me) {
    cmsSetCookie('cms.Models.Entity.ID', new_me.CookieID, null, null, cmsCookieHost, false)
    cmsSetCookie('cms.Models.Entity.SignIn', new_me.StatusCode, null, null, cmsCookieHost, false)
    cmsSetCookie('cms.Models.Entity.FullName', new_me.FullName, null, null, cmsCookieHost, false)
    cmsSetCookie('cms.Models.Entity.ActionCode', new_me.ActionCode, null, null, cmsCookieHost, false)
    cmsSetCookie('cms.Models.Entity.Custom2', new_me.Custom2, null, null, cmsCookieHost, false)

}

function cmsDeleteAllCookies() {
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i];
        var eqPos = cookie.indexOf("=");
        var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
}

// this fixes an issue with the old method, ambiguous values
// with this test document.cookie.indexOf( name + "=" );
function cmsSetCookie(name, value, expires, path, domain, secure) {
    // set time, it's in milliseconds
    var today = new Date();
    today.setTime(today.getTime());

    //alert('path = ' + path);
    path = '/';

    /*
    if the expires variable is set, make the correct
    expires time, the current script below will set
    it for x number of days, to make it for hours,
    delete * 24, for minutes, delete * 60 * 24
    */
    if (expires) {
        expires = expires * 1000 * 60 * 60 * 24;
    }
    var expires_date = new Date(today.getTime() + (expires));

    document.cookie = name + "=" + escape(value) +
((expires) ? ";expires=" + expires_date.toGMTString() : "") +
((path) ? ";path=" + path : "") +
((domain) ? ";domain=" + domain : "") +
((secure) ? ";secure" : "");
}
	

function cmsGetCookie(check_name) {
    // first we'll split this cookie up into name/value pairs
    // note: document.cookie only returns name=value, not the other components
    var a_all_cookies = document.cookie.split(';');
    var a_temp_cookie = '';
    var cookie_name = '';
    var cookie_value = '';
    var b_cookie_found = false; // set boolean t/f default f

    for (i = 0; i < a_all_cookies.length; i++) {
        // now we'll split apart each name=value pair
        a_temp_cookie = a_all_cookies[i].split('=');


        // and trim left/right whitespace while we're at it
        cookie_name = a_temp_cookie[0].replace(/^\s+|\s+$/g, '');

        // if the extracted name matches passed check_name
        if (cookie_name == check_name) {
            b_cookie_found = true;
            // we need to handle case where cookie has no value but exists (no = sign, that is):
            if (a_temp_cookie.length > 1) {
                cookie_value = unescape(a_temp_cookie[1].replace(/^\s+|\s+$/g, ''));
            }
            // note that in cases where cookie is initialized but no value, null is returned
            return cookie_value;
            break;
        }
        a_temp_cookie = null;
        cookie_name = '';
    }
    if (!b_cookie_found) {
        return null;
    }
}

function cmsDateDiffMinutes(pFirstDate, pSecondDate) {
    return ((pSecondDate.getHours() * 60) + pSecondDate.getMinutes()) - ((pFirstDate.getHours() * 60) + pFirstDate.getMinutes());
}

function cmsTimeoutReload(pSeconds) {
    //alert('here');
    setTimeout("cmsReload()", pSeconds * 1000);
}

function cmsReload() {
    //alert('here2');
    window.location.reload(true);
}

function cmsCheckboxToggle(pID, pSelected) {
    $("#" + pID + " input[type='checkbox']").each(function () {
        if (!this.disabled) {
            this.checked = pSelected;
        }
    });
}

function cmsCheckboxToggleInverse(pID, pSelected) {
    $("#" + pID + " input[type='checkbox']").each(function () {
        if (!this.disabled) {
            this.checked = !this.checked;
        }
    });
}

function cmsBtnSearchClick() {

}

function MoveOptionDown(pId) {
    var selectedOption = $('#' + pId + ' > option[selected]');
    var nextOption = $('#' + pId + ' > option[selected]').next("option");
    if ($(nextOption).text() != "") {
        $(selectedOption).remove();
        $(nextOption).after($(selectedOption));
    }
}

function MoveOptionUp(pId) {
    var selectedOption = $('#' + pId + ' > option[selected]');
    var prevOption = $('#' + pId + ' > option[selected]').prev("option");
    if ($(prevOption).text() != "") {
        $(selectedOption).remove();
        $(prevOption).before($(selectedOption));
    }
}

function cmsWindowOpenLink(pThis, pName, pFeatures, pReplace) {
    var oNewWindow = window.open(pThis.href, pName, pFeatures, pReplace);
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}

function cmsWindowOpen(pUrl, pName, pFeatures, pReplace) {
    var oNewWindow = window.open(pUrl, pName, pFeatures, pReplace);
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
    }
}

function cmsPopupImage(pUrl, pName) {
    var oNewWindow = window.open(pUrl, pName, 'directories=no,toolbar=no,location=no,menubar=no,status=no,titlebar=no');
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}

function cmsPopupImageSmall(pUrl, pName) {
    var oNewWindow = window.open(pUrl, pName, 'height=250,width=250,directories=no,toolbar=no,location=no,menubar=no,status=no,titlebar=no');
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}

function cmsPopupAnchor(pAnchor, pName) {
    var oNewWindow = window.open(pAnchor.href, pName, 'directories=no,toolbar=no,location=no,menubar=no,status=no,titlebar=no');
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}


function cmsPopupAnchorSmall(pAnchor, pName) {
    var oNewWindow = window.open(pAnchor.href, pName, 'height=250,width=250,directories=no,toolbar=no,location=no,menubar=no,status=no,titlebar=no');
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}

function cmsPopupAnchorMedium(pAnchor, pName) {
    var oNewWindow = window.open(pAnchor.href, pName, 'height=450,width=800,directories=no,toolbar=no,location=no,menubar=no,status=no,titlebar=no');
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}

function cmsPopupMediaGallery(pAnchor) {
    var pName = pAnchor.href;
    var oNewWindow = window.open(pAnchor.href, pName, 'height=450,width=800,resize=yes,directories=no,toolbar=no,location=no,menubar=no,status=no,titlebar=no');
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}

function cmsPopupAnchorMediumWidthQSPopup(pAnchor, pName) {
    var sHref = pAnchor.href;
    if(sHref.indexOf('?') != -1)
    {
        sHref = sHref + '&Popup=1';
    }
    else
    {
        sHref = sHref + '?Popup=1';
    }

    var oNewWindow = window.open(sHref, pName, 'height=450,width=800,directories=no,toolbar=no,location=no,menubar=no,status=no,titlebar=no');
    if (oNewWindow == null) {
        alert('Enable popups for this function.');
        return true;
    }
    return false;
}

function cmsConfirmDeleteItem() {
    return confirm('Confirm deletion of this item.\n\nWarning: this cannot be undone.');
}

function cmsGetKb(pBytes) {
    var num = 0.00;
    num = (parseInt(pBytes) / 1024);
    var s = num.toFixed(2) + "kb";
    return s;
}

function cmsIsImage(pFile) {
    var re = /^\S+\.(gif|jpg|jpeg|png)$/i;
    return re.test(pFile);
}

function cmsScrubUrlName(pValue) {
    var c = ' "\'&:*%+;?';
    var s = "";
    
    for (var i = 0; i < c.length; i++) {
        s = c.substr(i, 1);
        pValue = pValue.replace(s, '-');
    }
    return pValue;
}

function cmsClearEntry(pThis, pValue) {
    if (pThis.value == pValue) {
        pThis.value = '';
    }
}

function cmsTrapEnterKD(btnId, e) {
    var btn = document.getElementById(btnId);
    var key;

    if (btn == null) {
        return;
    }

    if (window.event) {
        //IE
        key = window.event.keyCode;
        if (key == 13) {
            btn.click();
            event.keyCode = 0;
        }
    }
    else {
        //firefox
        key = e.which;
        if (key == 13) {
            btn.click();
        }
    }
}

function cmsTrapEnterKDMoveNext(NextObjId, e) {
    var obj = document.getElementById(NextObjId);
    var key;

    if (obj == null) {
        return;
    }

    if (window.event) {
        //IE
        key = window.event.keyCode;
        if (key == 13) {
            obj.focus();
            event.keyCode = 0;
        }
    }
    else {
        //firefox
        key = e.which;
        if (key == 13) {
            obj.focus();
        }
    }
}

function cmsIsValidEmail(pEmail)
{
    if (pEmail.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1) {
        return true;
    }
    else {
        return false;
    }
}

function cmsIsValidObjEmail(pTexbox) {

    var string = pTextbox.value;
    
    if (string.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1) {
        return true;
    }
    else {
        return false;
    }
}

function cmsGup( name )
{
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}

function cmsToggleRadioButton(pID) {
    $("#" + pID + " input[type='radio']").each(function() {
        this.checked = !this.checked;
    });
}

function cmsToggleCheckBox(pID) {
    $("#" + pID + " input[type='checkbox']").each(function() {
        this.checked = !this.checked;
    });
}

function cmsRandomBetween(p1, p2) {
    var rand_no = Math.floor((p2 - (p1 - 1)) * Math.random()) + p1;
    return rand_no;
}

function cmsAlwaysTrue() {
    return true;
}

function cmsAlwaysFalse() {
    return false;
}

function cmsPetPointResizeThumbnails(maxWidth, maxHeight, selector) {
    $(selector).each(function (i) {
        var h;
        var w;

        if ($(this).height() > $(this).width()) {
            h = maxHeight;
            w = Math.ceil($(this).width() / $(this).height() * maxHeight);
        } else {
            w = maxWidth;
            h = Math.ceil($(this).height() / $(this).width() * maxWidth);
        }

        $(this).css({ height: h, width: w });
    });
}

/*$.fn.getIndex = function () {
    var $p = $(this).parent().children();
    return $p.index(this);
}*/

function cmsGetItemIndex(p) {
    var $p2 = $(p).parent().children();
    return $p2.index(p);
}

// lessons
function cmsResponse_OnTimeOut(arg) {
    alert("TimeOut encountered.");
    return false;
}

function cmsResponse_OnError(arg) {
    alert("Error encountered: " + arg);
    return false;
}
// end lessons

if (typeof String.prototype.startsWith != 'function') {
    String.prototype.startsWith = function (str) {
        return this.slice(0, str.length) == str;
    };
}

if (typeof String.prototype.endsWith != 'function') {
    String.prototype.endsWith = function (str) {
        return this.slice(-str.length) == str;
    };
}

function cmsShowProgressDialogZZZ() {
    alert('herecmsShowProgressDialog1');
    $.fancybox($('#cms-progress-dialog'));
    alert('herecmsShowProgressDialog2');
    //$.fancybox.showLoading() 

}

function cmsHideProgressDialogXXX() {
    $.fancybox.close(true);
}

function cmsShowProgressDialogXXXX() {
    $('#dialog').dialog();
}

function cmsHideProgressDialogXXXX() {

    alert('hereHide ');
    $('#dialog').dialog('close');
}


function cmsShowProgressDialogXX() {

    $("#cms-progress-dialog").dialog({
        'autoOpen': 'false',
        'modal': 'true',
        'closeOnEscape': 'true',
        'height': '300',
        'width': '200',
        position: 'center'
    });

    //    $('#cms-progress-dialog').dialog('open');
    $('#cms-progress-dialog').dialog('open');

}

function cmsHideProgressDialogXX() {
    $('#cms-progress-dialog').dialog('close');
   // if ($('#cms-progress-dialog').dialog('isOpen')) {
   // }
}

function cmsFormatBirthDate(myDateOfBirth) {
    var myDateOfBirthMonth = myDateOfBirth.getMonth();
    var myDateOfBirthDay = myDateOfBirth.getDay();
    var sMonth = myDateOfBirthMonth;


    if (myDateOfBirthMonth < 10) sMonth = '0' + myDateOfBirthMonth

    var sDay = myDateOfBirthDay;
    if (myDateOfBirthDay < 10) sDay = '0' + myDateOfBirthDay
}

function cmsLaxValueIn(val, p1, p2, p3, p4, p5) {
    
    if (val == p1) return true;

    if (val == p2) return true;

    if (val == p3) return true;

    if (p2) {
        
    }

    if (p3) {
        
    }

    if (p4) {
        if (val == p4) return true;
    }

    if (p5) {
        if (val == p5) return true;
    }
    

    return false;

}

// TZ 

function cmsAddMonth(d, month) {
    t = new Date(d);
    t.setMonth(d.getMonth() + month);
    if (t.getDate() < d.getDate()) {
        t.setDate(0);
    }
    return t;
}

function cmsSortableDateTime(d) {
    var dDate = d.getDate();
    var dMonth = d.getMonth() + 1;
    var dYear = d.getFullYear();

    var dHours = d.getHours();
    var dMinutes = d.getMinutes();

    var sMonth = dMonth + '';
    if (dMonth < 10) sMonth = '0' + dMonth;

    var sDate = dDate + '';
    if (dDate < 10) sDate = '0' + dDate;

    var sHours = dHours + '';
    if (dHours < 10) sHours = '0' + dHours;

    var sMinutes = dMinutes + '';
    if (dMinutes < 10) sMinutes = '0' + dMinutes;

    return dYear + '-' + sMonth + '-' + sDate + ' ' + sHours + ':' + sMinutes;
}


function cmsSortableDateTimeMilliseconds(d) {
    var dDate = d.getDate();
    var dMonth = d.getMonth() + 1;
    var dYear = d.getFullYear();

    var dHours = d.getHours();
    var dMinutes = d.getMinutes();
    var dSeconds = d.getSeconds();
    var dMilliseconds = d.getMilliseconds();

    var sMonth = dMonth + '';
    if (dMonth < 10) sMonth = '0' + dMonth;

    var sDate = dDate + '';
    if (dDate < 10) sDate = '0' + dDate;

    var sHours = dHours + '';
    if (dHours < 10) sHours = '0' + dHours;

    var sMinutes = dMinutes + '';
    if (dMinutes < 10) sMinutes = '0' + dMinutes;

    var sReturn = dYear + '-' + sMonth + '-' + sDate + ' ' + sHours + ':' + sMinutes + ':' + dSeconds + '.' + cmsPadNumber(dMilliseconds, 4);

    return sReturn;
}


function cmsPadNumber(number, length) {
    var str = '' + number;
    while (str.length < length) {
        str = '0' + str;
    }

    return str;
}

function cmsGetUTCDate() {
    //return new Date();
    var nowDate = new Date(new Date().toUTCString());
    //var nowOffset = nowDate.getTimezoneOffset();
    return nowDate;// + nowOffset;
    //return new Date(Date.UTC());
}

function cmsInitAllTz2() {
    var iCount = cmsAllTz2();
    if (!cmsPageTimerTz2Set) {
        cmsPageTimerTz2 = setInterval("cmsAllTz2()", 1000)
        cmsPageTimerTz2Set;
    };
}

function cmsAllTz2() {
    var iCount = 0;
    $('[data-tz2]').each(function (index) {
        iCount++;
        cmsSetTz2Clock(this);

    });
    return iCount;
}

function cmsSetTz2Clock(p) {
    var s_targetInMS = $(p).attr('data-tz2');
    if (s_targetInMS + '' == '')
        return;

    var targetDate = cmsAdjustTz1(new Date(s_targetInMS));
    var sDisplay = cmsGetTz2Count(targetDate);

    if (sDisplay == '00:00:00') {
        var targetID = $(p).attr('id');
        var fsTargetID = targetID.replace('timer-', 'fs-');
        $('#' + fsTargetID + ' span.score-stub').css('display', 'none');
        fsTargetID = targetID.replace('timer-', 'timer-warning-');
        $('#' + fsTargetID).css('display', 'block');
    }

    $(p).text(sDisplay);
    var altID = '#' + $(p).attr('id') + '-tab';
    $(altID).text(sDisplay);
}

function cmsGetTz2Count(dFutureDate) {

    var dateNow = cmsGetUTCDate();// new Date();// cmsGetUTCDate(); //grab current date
    var amount = dFutureDate.getTime() - dateNow.getTime();	//calc milliseconds between dates
    delete dateNow;

    // if time is already past
    if (amount < 0) {
        return '00:00:00';
    }
        // else date is still good
    else {
        var days = 0; var hours = 0; var mins = 0; var secs = 0; var out = '';

        amount = Math.floor(amount / 1000);//kill the "milliseconds" so just secs

        days = Math.floor(amount / 86400);//days
        amount = amount % 86400;

        hours = Math.floor(amount / 3600);//hours
        amount = amount % 3600;

        mins = Math.floor(amount / 60);//minutes
        amount = amount % 60;

        secs = Math.floor(amount);//seconds

        if (days != 0) { hours = hours + (days * 24); }

        var sHours = '00';
        var sMins = '00';
        var sSecs = '00';

        if (hours > 9) {
            sHours = hours;
        } else {
            sHours = '0' + hours;
        }

        if (mins > 9) {
            sMins = mins;
        } else {
            sMins = '0' + mins;
        }

        if (secs > 9) {
            sSecs = secs;
        } else {
            sSecs = '0' + secs;
        }

        out = sHours + ':' + sMins + ':' + sSecs;
        return out;
    }
}

function cmsSelectiveTz1(p) {
    $(p + ' [data-fx1]').each(function (index) {
        $(this).text(cmsTzStr1(cmsAdjustTz1($(this).attr('data-fx1'))));
    });
}

function cmsAllTz1() {
    $('[data-fx1]').each(function (index) {
        if ($(this).attr('data-fx1-f')) {
            $(this).text(cmsTzStr1Formatted($(this).attr('data-fx1-f'), cmsAdjustTz1($(this).attr('data-fx1'))));
        }
        else {
            $(this).text(cmsTzStr1(cmsAdjustTz1($(this).attr('data-fx1'))));
        }
    });
}

function cmsTzStr1(d) {
    //return $.datepicker.formatDate(defaultFx1Format, d) + ' ' + d.toLocaleTimeString();
    var fdate = $.datepicker.formatDate(defaultFx1Format, d) + ' ' + d.toLocaleTimeString();
    fdate = fdate.substring(0, fdate.length - 6) + ' ' + fdate.substring(fdate.length - 2, fdate.length);
    return fdate;

    //return d.toLocaleDateString() + ' ' + d.toLocaleTimeString();
}

function cmsTzStr1Formatted(f, d) {
    return $.datepicker.formatDate(f, d);
    /*
    var fdate = $.datepicker.formatDate(f, d);
    fdate = fdate.substring(0, fdate.length - 6) + ' ' + fdate.substring(fdate.length - 2, fdate.length);
    return fdate;
    */
}

function cmsSetTz1(p) {
    var d = new Date($(p).attr('data-fx1'));
    $(p).text(d.setHours(d.getHours() + cmsTzCalcOffset()));
}

function cmsAdjustTz1(d) {
    var d2 = new Date(d);
    d2.setHours(d2.getHours() + cmsTzCalcOffset());
    return d2;
}

function cmsTzOffsetSetCookie() {
    var oHours = cmsTzCalcOffset();
    document.cookie = 'cmsTzOffset=' + oHours.toString();
    //alert(getCookieValue('cmsTzOffset'));
}

function cmsTzCalcOffset() {
    var d = new Date();
    var oMinutes = d.getTimezoneOffset();
    var oHours = -1 * (oMinutes / 60);
    return oHours;
}

function cmsEntityGetPetPreference() {
    var mycookie = cmsGetCookie('cms.Models.Entity.Custom.Pet');
    if (mycookie != '') {
        if (myCookie.indexOf('dog') > -1 && mycookie.indexOf('cat')) {
            return 'both-dog-cat';
        }
        else {
            if (myCookie.indexOf('dog') > -1) {
                return 'dog';
            }
            if (myCookie.indexOf('cat') > -1) {
                return 'cat';
            }
        }
        return '';
    }
    return '';
}

// new 2013-09-30
function cmsAjaxContentVideoGallery(pUrl, pOrder, pLastChain) {
    var cmsAjaxContentVideoGallery_Return = {};

    var cmsAjaxContentVideoGallery_Url = '/Ajax/ContentVideoGallery?item=' + pUrl + '&order=' + pOrder + '&lastChain=' + pLastChain;

    $.ajax({
        url: cmsAjaxContentVideoGallery_Url,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'json',
        success: function (json) {
            cmsAjaxContentVideoGallery_Return = json;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            cmsAjaxContentVideoGallery_Return.HasError = true;
            cmsAjaxContentVideoGallery_Return.StatusCode = 'ERR_AJAX';
            cmsAjaxContentVideoGallery_Return.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    return cmsAjaxContentVideoGallery_Return;
}

function cmsContentVideoGallerySetupVideo(pSelector, pVideoUrl) {
    try {
        jwplayer(pSelector).setup({
            flashplayer: "/Scripts/player.swf",
            file: pVideoUrl,
            autostart: 'false',
            width: '450',
            height: '300',
            //'image' : useImageSrc,
            //icons: 'false',

            events: {
                onError: function (event) {
                    //cmsLanding_VideoError();
                }
            }
        });
    }

    catch (Error) {
        //alert(Error);
        return false;
    }

    return true;
}


function cmsBrownButtonDisable(p) {
    $(p).attr('disabled', 'disable');
    $(p).removeClass('cms-enabled').removeClass('cms-disabled').addClass('cms-disabled');
}

function cmsBrownButtonEnable(p) {
    $(p).removeAttr('disabled');
    $(p).removeClass('cms-disabled').removeClass('cms-enabled').addClass('cms-enabled');
}

function cmsCheckForGlobalNotice() {
    if (cmsSiteGlobalNotice != '') {
        $('#header-notice-content').html(cmsSiteGlobalNotice);
        $('#header-notice').toggle(true);
    }
}

function cmsCheckForSiteMaintenance() {
    if (cmsSiteDownForMaintenance) {
        $('#header-right').toggle(false);
        $('#section-landing').toggle(false);
        $('#section-detail').toggle(false);
        $('#footer-main').toggle(false);
        return true;
    }

    return false;
}

function cmsIsLessThan(pVal1, pVal2) {
    if (pVal1 < pVal2) {
        return true;
    }
    return false;
}

function cmsIsGreaterThan(pVal1, pVal2) {
    if (pVal1 > pVal2) {
        return true;
    }
    return false;
}

function cmsIsGreaterThanOrEqual(pVal1, pVal2) {
    if (pVal1 > pVal2) {
        return true;
    }
    return false;
}

//2014-06-28
function cmsGALogEventUrl(pCategory, pAction, pUrlAsLabel) {
    var eventCategory = pCategory;
    var eventAction = pAction;
    var eventLabel = pUrlAsLabel;
    if (eventLabel.indexOf('/') == -1) {
        eventLabel = '/' + eventLabel;
    }

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogEvent(pCategory, pAction, pLabel) {
    var eventCategory = pCategory;
    var eventAction = pAction;
    var eventLabel = pLabel;

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogViewPetDetailEvent(pSpecies, pID) {
    var eventCategory = 'View-PetDetail-' + pSpecies;
    var eventAction = 'View';
    var eventLabel = pID;

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            //alert(eventCategory + ' | ' + eventAction + ' | ' + eventLabel);
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogViewPrimaryEvent() {
    if(cms_primary_url + '' != '')
    {
        var eventCategory = 'View-Primary-' + cms_primary_url;
        var eventAction = 'View';
        var eventLabel = cms_url;
        if (eventLabel.indexOf('/') == -1) {
            eventLabel = '/' + eventLabel;
        }

        try {
            if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
                //alert(eventCategory + ' | ' + eventAction + ' | ' + eventLabel);
                ga('send', 'event', eventCategory, eventAction, eventLabel);
            }
        }
        catch (err)
        { }
    }
}

function cmsGALogViewContentTreeEvent() {
    var eventCategory = 'View-Tree';
    var eventAction = 'Site';
    var eventLabel = cms_url;

    if (cms_tertiary_url + '' != '' && cms_tertiary_url + '' != '/') {
        eventCategory = 'View-Tree';
        eventAction = 'Tertiary';
        eventLabel = '/site/' + cms_primary_url + '/' + cms_secondary_url + '/' + cms_tertiary_url;
        if (eventLabel.indexOf('/') == -1) {
            eventLabel = '/' + eventLabel;
        }

        try {
            if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
                ga('send', 'event', eventCategory, eventAction, eventLabel);
            }
        }
        catch (err)
        { }
    }
    else if (cms_secondary_url + '' != '' && cms_secondary_url + '' != '/') {
        eventCategory = 'View-Tree';
        eventAction = 'Secondary';
        eventLabel = '/site/' + cms_primary_url + '/' + cms_secondary_url;
        if (eventLabel.indexOf('/') == -1) {
            eventLabel = '/' + eventLabel;
        }

        try {
            if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
                ga('send', 'event', eventCategory, eventAction, eventLabel);
            }
        }
        catch (err)
        { }
    }
    else if (cms_primary_url + '' != '') {
        eventCategory = 'View-Tree' + cms_primary_url;
        eventAction = 'Primary';
        eventLabel = '/site/' + cms_primary_url;
        if (eventLabel.indexOf('/') == -1) {
            eventLabel = '/' + eventLabel;
        }

        try {
            if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
                ga('send', 'event', eventCategory, eventAction, eventLabel);
            }
        }
        catch (err)
        { }
    }

    
}

function cmsGALogFormEvent(pAction) {
    var eventCategory = 'Form-' + pAction;
    var eventAction = pAction;
    var eventLabel = cms_url;
    if (eventLabel.indexOf('/') == -1) {
        eventLabel = '/' + eventLabel;
    }

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            //alert(eventCategory + ' | ' + eventAction + ' | ' + eventLabel);
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

//2014-06-28 end

function cmsRemoveSettings() {
    if (!confirm('If you have been directed to use this function, or if you are having difficulty with sign-in values, this feature will remove all "cookies" with your browser.  You will also be signed-out and the page will reload if you continue.')) {
        return '';
    }
    var xReturn = '';

    cmsDeleteAllCookies();
    xReturn = cmsServerClearCookies();
    //window.location.reload(true);
    return xReturn;
}

function cmsDeleteAllCookies() {
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i];
        var eqPos = cookie.indexOf("=");
        var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
}

function cmsServerClearCookies() {
    var ServerClearCookies_Return = '';

    $.ajax({
        url: '/cmx/ClearCookies.ashx',
        async: false,
        cache: false,
        type: 'GET',
        success: function (data) {
            ServerClearCookies_Return = data;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            ServerClearCookies_Return = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;
        }
    });

    return ServerClearCookies_Return;
}

//cmsSetDetailAndSidebarActive

function cmsSetDetailAndSidebarActive3(currentUrl, primaryUrl, secondaryUrl, tertiaryUrl) {
    cmsSetDetailMenuActive(primaryUrl);
    cmsSetSidebarActive3(currentUrl, primaryUrl, secondaryUrl);
}

function cmsSetSidebarActive3(currentUrl, primaryUrl, secondaryUrl, tertiaryUrl) {
    var cmsSetSidebarActive_Debug = 0;
    var exitSub = false;
    var cmsID;
    var cmsURL;
    var sidebarDiv;
    var sidebarDivChildren;
    var sidebarActiveSet = false;
    var highlighted = "";

    //clear all for any active state
    $('#sidebar-accordion').children('h3.sidebar-item-header').removeClass('ui-state-active');
    $('#sidebar-accordion').children('h3.sidebar-item-header').removeClass('ui-highlighted-state-active');
    $('#sidebar-accordion').children('h3.sidebar-item-header').addClass('ui-state-default');

    $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
        highlighted = $(this).attr('data-cms-css');
        if (highlighted == 'highlighted') {
            $(this).addClass('ui-highlighted-state-default');
        }
    });

    // hide arrow
    $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
        cmsID = $(this).attr('data-cms-id');
        sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');
        sidebarDivChildren = sidebarDiv.children();
        $(this).attr('data-cms-child-count', sidebarDivChildren.length);
        highlighted = $(this).attr('data-cms-css');

        if (sidebarDivChildren.length == 0) {
            if (highlighted == 'highlighted') {
                $(this).css('background-image', 'url("/Content/img/ui/bg-sidebar-item-highlighted-noarrow.png")');
            }
            else {
                $(this).css('background-image', 'url("/Content/img/ui/bg-sidebar-item-noarrow.png")');
            }

        }
    });

    // we're on primary page -- find first item with content and open it
    if (cms_enumtype == 101) {
        if (0 == 1) {
            $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

                if (exitSub) { return; }

                cmsID = $(this).attr('data-cms-id');
                cmsURL = $(this).attr('data-cms-url');

                sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

                if ($(this).attr('data-cms-child-count') > 0) {
                    $(sidebarDiv).css('display', 'block');
                    exitSub = true;
                }

            });
        }
    }
    else if (cms_enumtype == 102) {
        //alert(102);
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-url') == cms_secondary_url) {
                    $(sidebarDiv).css('display', 'block');
                    exitSub = true;
                }

            }
        });
    }
    else if (cms_enumtype == 103) {
        //alert(103);
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-secondary-url') == cms_secondary_url) {
                    if ($(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_url + '"]').length > 0) {
                        $(sidebarDiv).css('display', 'block');
                        $(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_url + '"]').css('font-weight', 'bold');
                        exitSub = true;
                    }

                }
            }

        });
    } else if (cms_enumtype == 104) {
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-secondary-url') == cms_secondary_url) {
                    $(sidebarDiv).css('display', 'block');
                    $(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_tertiary_url + '"]').css('font-weight', 'bold');
                    exitSub = true;
                }
            }

        });
    } else {
        if (0 == 1) {
            $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

                if (exitSub) { return; }

                cmsID = $(this).attr('data-cms-id');
                cmsURL = $(this).attr('data-cms-url');

                sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

                if ($(this).attr('data-cms-child-count') > 0) {
                    if ($(this).attr('data-cms-url') == cms_url) {
                        $(sidebarDiv).css('display', 'block');
                        exitSub = true;
                    }
                }

            });
        }
    }
}

//cmsSetDetailAndSidebarActive

function cmsSetDetailAndSidebarActive4(currentUrl, primaryUrl, secondaryUrl, tertiaryUrl) {
    cmsSetDetailMenuActive(primaryUrl);
    cmsSetSidebarActive4(currentUrl, primaryUrl, secondaryUrl);
}

function cmsSetSidebarActive4(currentUrl, primaryUrl, secondaryUrl, tertiaryUrl) {
    var cmsSetSidebarActive_Debug = 0;
    var exitSub = false;
    var cmsID;
    var cmsURL;
    var sidebarDiv;
    var sidebarDivChildren;
    var sidebarActiveSet = false;
    var highlighted = "";

    if (currentUrl == '/' && !cmsSitePageViewRepeatVisitor) {
        $('#sidebar').css('display', 'none');
        return;
    }

    if (currentUrl == '/' && cmsSitePageViewRepeatVisitor) {
        $('#sidebar').css('display', '');

        $('#sidebar-accordion div.sidebar-outer').css('display', 'none');

        cmsSetSidebarByFlags();

        $('#sidebar-accordion div.sidebar-outer div.sidebar-item-main').css('display', 'block');
        $('#sidebar-accordion div.sidebar-outer::first').css('display', 'block');
        return;
    }

    //clear all for any active state
    $('#sidebar-accordion').children('h3.sidebar-item-header').removeClass('ui-state-active');
    $('#sidebar-accordion').children('h3.sidebar-item-header').removeClass('ui-highlighted-state-active');
    $('#sidebar-accordion').children('h3.sidebar-item-header').addClass('ui-state-default');

    $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
        highlighted = $(this).attr('data-cms-css');
        if (highlighted == 'highlighted') {
            $(this).addClass('ui-highlighted-state-default');
        }
    });

    // hide arrow
    $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
        cmsID = $(this).attr('data-cms-id');
        sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');
        sidebarDivChildren = sidebarDiv.children();
        $(this).attr('data-cms-child-count', sidebarDivChildren.length);
        highlighted = $(this).attr('data-cms-css');

        if (sidebarDivChildren.length == 0) {
            if (highlighted == 'highlighted') {
                $(this).css('background-image', 'url("/Content/img/ui/bg-sidebar-item-highlighted-noarrow.png")');
            }
            else {
                $(this).css('background-image', 'url("/Content/img/ui/bg-sidebar-item-noarrow.png")');
            }

        }
    });

    // we're on primary page -- find first item with content and open it
    if (cms_enumtype == 101) {

    }
    else if (cms_enumtype == 102) {
        //alert(102);
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-url') == cms_secondary_url) {
                    $(sidebarDiv).css('display', 'block');
                    exitSub = true;
                }

            }
        });
    }
    else if (cms_enumtype == 103) {
        //alert(103);
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {

            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-secondary-url') == cms_secondary_url) {
                    if ($(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_url + '"]').length > 0) {
                        $(sidebarDiv).css('display', 'block');
                        $(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_url + '"]').css('font-weight', 'bold');
                        exitSub = true;
                    }

                }
            }

        });
    } else if (cms_enumtype == 104) {
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-secondary-url') == cms_secondary_url) {
                    $(sidebarDiv).css('display', 'block');
                    $(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_tertiary_url + '"]').css('font-weight', 'bold');
                    exitSub = true;
                }
            }

        });
    } else if (cms_template == 'Forum' || cms_enumtype == 16) {
        $('#sidebar-accordion h3.sidebar-item-header').each(function (index) {
            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            sidebarDiv = $('div.sidebar-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-secondary-url') == cms_secondary_url) {
                    $(sidebarDiv).css('display', 'block');
                    $(sidebarDiv).children('div.sidebar-nav-list').children('div.title').children('a[data-cms-url = "' + cms_tertiary_url + '"]').css('font-weight', 'bold');
                    exitSub = true;
                }
            }

        });
    } else {

    }

    // new sidebar properties
    cmsSetSidebarByFlags();

}

/* cms.005.js */

function cmsItemShowSplash(pWidth, pHeight, pItemForHtml) {
    if (cmsItemSaveSplashHtml == null) {
        cmsItemSaveSplashHtml = $('#cms-splash').html();
    }

    if (pWidth != null) $('#cms-splash').css('width', pWidth);
    if (pHeight != null) $('#cms-splash').css('height', pHeight);

    $('#cms-splash').html($(pItemForHtml).html());
    $('#a-cms-splash').click();
}

function cmsSetSidebarByFlags() {
    $('#sidebar-accordion div.sidebar-outer[data-cms-NotCollapsible="true"] a.sidebar-item-toggle').css('visibility', 'hidden');
    $('#sidebar-accordion div.sidebar-outer[data-cms-NoLandingLink="true"] a.sidebar-item-link').attr('href', '#');
    $('#sidebar-accordion div.sidebar-outer[data-cms-NoLandingLink="true"] a.sidebar-item-link').attr('onclick', 'return false;');
    $('#sidebar-accordion div.sidebar-outer[data-cms-NoLandingLink="true"] a.sidebar-item-toggle').css('visibility', 'hidden'); //?
}

/* pooled from views */
/* footer menu */
function footerButtonRemoveSettingsClick() {
    var x = cmsRemoveSettings();
    if (x == null || x == '') {
        return;
    }

    alert('Your settings have been cleared. Your browser page will now refresh.');
    window.location.reload(true);
}


/*sidebar */
function cms_ToggleSidebarItem(p) {
    var cmsid = p;// $(p).attr('data-cms-id');
    var wasexpanded = $('#sidebar-accordion div.sidebar-item-main[data-cms-id = "' + cmsid + '"]').is(':visible');


    // turn all off
    $('#sidebar-accordion div.sidebar-outer').each(function () {
        var notCollapsible = $(this).attr('data-cms-NotCollapsible');
        if (notCollapsible == "true") {
            // do nothing
        }
        else {
            $(this).find('div.sidebar-item-main').hide('fast');

            $(this).find('a.sidebar-item-toggle').removeClass('ui-state-active').addClass('ui-state-default');
            //$('#sidebar-accordion').children('h3.sidebar-item-header').addClass('ui-state-default');

            //now toggle

            $(this).find('div.sidebar-item-toggle-column[data-cms-id = "' + cmsid + '"] a').toggleClass('ui-state-default', wasexpanded);
            $(this).find('div.sidebar-item-toggle-column[data-cms-id = "' + cmsid + '"] a').toggleClass('ui-state-active', !wasexpanded);

            if (!wasexpanded) {
                $(this).find('div.sidebar-item-main[data-cms-id = "' + cmsid + '"]').show('fast');
            }
        }
    });
}

/* OffCanvas Nav */
function cmsSetOffCanvasMenuActive(currentUrl, primaryUrl, secondaryUrl, tertiaryUrl) {
    var cmsSetSidebarActive_Debug = 0;
    var exitSub = false;
    var cmsID;
    var cmsURL;
    var offcanvasDiv;
    var offcanvasDivChildren;
    var offcanvasActiveSet = false;
    var highlighted = "";


    $('#cms-offcanvas-menu div.offcanvas-item-toggle-column').each(function (index) {
        var cmsid = $(this).attr('data-cms-id');
        var itemMain = $('#cms-offcanvas-menu').find('div.offcanvas-item-main[data-cms-id="' + cmsid + '"]');
        if ($(itemMain).find('div.offcanvas-nav-list div.title').length == 0) {
            $(this).find('a.offcanvas-item-toggle').css('visibility', 'hidden');
            $(this).closest('div.offcanvas-outer').attr('data-cms-HasExpandableContent', 'false');
        }
        else {
            $(this).closest('div.offcanvas-outer').attr('data-cms-HasExpandableContent', 'true');
        }
    });


    $('#cms-off-canvas-list-item-secondary-CurrentPrimary').find('a').attr('href', cms_primary_url);
    $('#cms-off-canvas-list-item-secondary-CurrentPrimary').find('a').text(cms_primary_virtualtitle);
    if (cms_enumtype == 101) {

    }
    else if (cms_enumtype == 102) {
        var currentSecondary = $('#cms-offcanvas-menu').find('div.offcanvas-outer[data-cms-secondary-url="' + cms_secondary_url + '"]');
        var cmsid = cms_id;
        if (currentSecondary.length > 0) {
            if ($(currentSecondary).attr('data-cms-HasExpandableContent') == "true") {
                $('#cms-offcanvas-menu').find('div.offcanvas-item-toggle-column[data-cms-id = "' + cmsid + '"] a').removeClass('ui-state-default').addClass('ui-state-active');
                $('#cms-offcanvas-menu').find('div.offcanvas-item-main[data-cms-id = "' + cmsid + '"]').show('fast');
            }
        }


    }
    else if (cms_enumtype == 103) {

        var currentSecondary = $('#cms-offcanvas-menu').find('div.offcanvas-outer[data-cms-secondary-url="' + cms_secondary_url + '"]');
        var cmsid = $(currentSecondary).attr('data-cms-id');
        if (currentSecondary.length > 0) {
            if ($(currentSecondary).attr('data-cms-HasExpandableContent') == "true") {
                $('#cms-offcanvas-menu').find('div.offcanvas-item-toggle-column[data-cms-id = "' + cmsid + '"] a').removeClass('ui-state-default').addClass('ui-state-active');
                $('#cms-offcanvas-menu').find('div.offcanvas-item-main[data-cms-id = "' + cmsid + '"]').show('fast');

                $('#cms-offcanvas-menu').find('div.offcanvas-item-main[data-cms-id = "' + cmsid + '"]').find('div.offcanvas-nav-list div.title a[data-cms-url = "' + cms_url + '"]').css('font-weight', 'bold');
            }
        }

    } else if (cms_enumtype == 104) {
        var currentSecondary = $('#cms-offcanvas-menu').find('div.offcanvas-outer[data-cms-secondary-url="' + cms_secondary_url + '"]');
        var cmsid = $(currentSecondary).attr('data-cms-id');
        if (currentSecondary.length > 0) {
            if ($(currentSecondary).attr('data-cms-HasExpandableContent') == "true") {
                $('#cms-offcanvas-menu').find('div.offcanvas-item-toggle-column[data-cms-id = "' + cmsid + '"] a').removeClass('ui-state-default').addClass('ui-state-active');
                $('#cms-offcanvas-menu').find('div.offcanvas-item-main[data-cms-id = "' + cmsid + '"]').show('fast');

                $('#cms-offcanvas-menu').find('div.offcanvas-item-main[data-cms-id = "' + cmsid + '"]').find('div.offcanvas-nav-list div.title a[data-cms-url = "' + cms_url + '"]').css('font-weight', 'bold');
            }
        }


    } else if (cms_template == 'Forum' || cms_enumtype == 16) {
        /*
        $('#cms-offcanvas-menu h3.offcanvas-item-header').each(function (index) {
            if (exitSub) { return; }

            cmsID = $(this).attr('data-cms-id');

            offcanvasDiv = $('div.offcanvas-item-main[data-cms-id = "' + cmsID + '"]');

            if ($(this).attr('data-cms-child-count') > 0) {
                if ($(this).attr('data-cms-secondary-url') == cms_secondary_url) {
                    $(offcanvasDiv).css('display', 'block');
                    $(offcanvasDiv).children('div.offcanvas-nav-list').children('div.title').children('a[data-cms-url = "' + cms_tertiary_url + '"]').css('font-weight', 'bold');
                    exitSub = true;
                }
            }

        });
        */
    } else {

    }

    // new offcanvas properties
    cmsSetOffCanvasMenuByFlags();

}

function cmsSetOffCanvasMenuByFlags() {
    $('#cms-offcanvas-menu div.offcanvas-outer-primary[data-cms-NotCollapsible="true"] a.offcanvas-item-toggle[data-cms-level="primary"]').css('visibility', 'hidden');
    $('#cms-offcanvas-menu div.offcanvas-outer-primary[data-cms-NoLandingLink="true"] a.offcanvas-item-link[data-cms-level="primary"]').attr('href', '#');
    $('#cms-offcanvas-menu div.offcanvas-outer-primary[data-cms-NoLandingLink="true"] a.offcanvas-item-link[data-cms-level="primary"]').attr('onclick', 'return false;');
    $('#cms-offcanvas-menu div.offcanvas-outer-primary[data-cms-NoLandingLink="true"] a.offcanvas-item-toggle[data-cms-level="primary"]').css('visibility', 'hidden'); //?

    $('#cms-offcanvas-menu div.offcanvas-outer-secondary[data-cms-NotCollapsible="true"] a.offcanvas-item-toggle[data-cms-level="secondary"]').css('visibility', 'hidden');
    $('#cms-offcanvas-menu div.offcanvas-outer-secondary[data-cms-NoLandingLink="true"] a.offcanvas-item-link[data-cms-level="secondary"]').attr('href', '#');
    $('#cms-offcanvas-menu div.offcanvas-outer-secondary[data-cms-NoLandingLink="true"] a.offcanvas-item-link[data-cms-level="secondary"]').attr('onclick', 'return false;');
    $('#cms-offcanvas-menu div.offcanvas-outer-secondary[data-cms-NoLandingLink="true"] a.offcanvas-item-toggle[data-cms-level="secondary"]').css('visibility', 'hidden'); //?

    $('#cms-offcanvas-menu div.offcanvas-outer-secondary').each(function (index) {
        if ($(this).find('div.offcanvas-nav-list div.title').length == 0) {
            $(this).find('a.offcanvas-item-toggle').css('visibility', 'hidden');
        }
    });

    $('#cms-offcanvas-menu offcanvas-outer-primary').each(function (index) {
        var item_primary_url = $(this).attr('data-cms-primary-url');
        if (item_primary_url == cms_primary_url) {

        }
    });

}

function cmsSetOffCanvasMenuActive() {
    $('#cms-offcanvas-menu .offcanvas-outer-primary').each(function (index) {
        var item_primary_url = $(this).attr('data-cms-primary-url');
        if (item_primary_url == cms_primary_url) {
            cms_ToggleOffCanvasPrimary($(this).find('a.offcanvas-item-toggle'), $(this).attr('data-cms-id'));

            $(this).find('.offcanvas-outer-secondary').each(function (index) {
                var item_secondary_url = $(this).attr('data-cms-secondary-url');
                var secondaryID = $(this).attr('data-cms-id');

                if (item_secondary_url == cms_secondary_url) {
                    cms_ToggleOffCanvasSecondary($(this).find('a.offcanvas-item-toggle'), secondaryID);

                    $(this).find('div.offcanvas-nav-list div.title a[data-cms-url="' + cms_url + '"]').css('font-weight', 'bold');
                    return;
                }
            });
        }
    });
}

function cms_ToggleOffCanvasPrimary(p, primaryID) {
    
    var initiallyVisible = $('#cms-offcanvas-list-secondary-' + primaryID).is(':visible');
    $('.offcanvas-outer-primary .offcanvas-item-sub-secondary').css('display', 'none');
    $('.offcanvas-outer-primary a.offcanvas-item-toggle[data-cms-level="primary"]').removeClass('cms-offcanvas-menu-opened'); //.addClass('cms-offcanvas-menu-closed');


    if (initiallyVisible) {
        $('.offcanvas-outer-primary[data-cms-id="' + primaryID + '"]').find('.offcanvas-item-primary').find('a.offcanvas-item-toggle[data-cms-level="primary"]').removeClass('cms-offcanvas-menu-opened').addClass('cms-offcanvas-menu-closed');
        $('#cms-offcanvas-list-secondary-' + primaryID).css('display', 'none');
    }
    else {
        //$(p).removeClass('cms-offcanvas-menu-closed').addClass('cms-offcanvas-menu-opened');
        $('.offcanvas-outer-primary[data-cms-id="' + primaryID + '"]').find('.offcanvas-item-primary').find('a.offcanvas-item-toggle[data-cms-level="primary"]').removeClass('cms-offcanvas-menu-opened').addClass('cms-offcanvas-menu-closed');
        $('#cms-offcanvas-list-secondary-' + primaryID).css('display', 'block');
    }
}

function cms_ToggleOffCanvasSecondary(p, secondaryID) {
    var initiallyVisible = $('#cms-offcanvas-list-tertiary-' + secondaryID).is(':visible');
    $('.offcanvas-outer-secondary .offcanvas-item-sub-tertiary').css('display', 'none');
    $('.offcanvas-outer-secondary a.offcanvas-item-toggle[data-cms-level="secondary"]').removeClass('cms-offcanvas-menu-opened').addClass('cms-offcanvas-menu-closed');

    if (initiallyVisible) {
        $(p).removeClass('cms-offcanvas-menu-opened').addClass('cms-offcanvas-menu-closed');
        $('#cms-offcanvas-list-tertiary-' + secondaryID).css('display', 'none');
    }
    else {
        $(p).removeClass('cms-offcanvas-menu-closed').addClass('cms-offcanvas-menu-opened');
        $('#cms-offcanvas-list-tertiary-' + secondaryID).css('display', 'block');
    }
}

// cms.006.js
function cmsPlayPopupVideo(pId, pVideoUrl, pImageSrc, pWidth, pHeight) {

    $('#cms-lightbox-video-inner').html('<div><a href="' + pVideoUrl + '" target="_blank" id="' + pId + '">' + pVideoUrl + '</a></div>');

    try {
        jwplayer(pId).setup({
            flashplayer: "/Scripts/player.swf",
            file: pVideoUrl,
            //wmode: 'transparent',
            autostart: 'true',
            width: pWidth,
            height: pHeight
            //'controlbar.position': 'none',
            /*'image' : pImageSrc,*/
            //icons: 'false'
        });
    }

    catch (Error) {
        alert("We're sorry, we were unable to play the video.");
        return;
    }

    $('#a-cms-lightbox-video').click();

}


// cms.007.js
function cmsPlayPopupYouTubeVideo(pId, pWidth, pHeight) {

    $('#cms-lightbox-video-inner').html('<div><iframe width="' + pWidth + '" height="' + pHeight + '" src="//www.youtube.com/embed/' + pId + '?autoplay=1&rel=0" frameborder="0" allowfullscreen></iframe></div>');
    
    $('#a-cms-lightbox-video').click();

}
//

//2014-07-18 
function cmsAdoptForm_rb_Location_changed(pVal, defaultPetID) {

    if (pVal == 'manhattan') {
        $('#tr-select-pet').toggle(true);
        $('#select_pet').find('option').remove();
        $('#div_pet_list_manhattan').find('span').each(function (index) {
            $('#select_pet').append($('<option></option').attr('value', $(this).attr('data-id')).text($(this).text()));
        });

        $('#form-fs2').removeClass('cms-form-closed').addClass('cms-form-open');
        $('#form-fs2').find('div.cms-form').toggle(true);
    }
    else if (pVal == 'westhampton') {
        $('#tr-select-pet').toggle(true);
        $('#select_pet').find('option').remove();
        $('#div_pet_list_westhampton').find('span').each(function (index) {
            $('#select_pet').append($('<option></option').attr('value', $(this).attr('data-id')).text($(this).text()));
        });
        $('#form-fs2').removeClass('cms-form-closed').addClass('cms-form-open');
        $('#form-fs2').find('div.cms-form').toggle(true);
    }
    else {
        $('#tr-select-pet').toggle(false);
        $('#select_pet').find('option').remove();
    }

    cmsAdoptForm_select_pet_changed(defaultPetID);

}


function cmsAdoptForm_select_pet_changed(pID) {


    var pet_id;
    var pet_name;

    if (!isNaN(parseInt(pID))) {
        if ($('#select_pet option[value="' + pID + '"]').length > 0) {
            $('#select_pet').val(pID + '');
        }
    }

    pet_id = $('#select_pet').val();
    pet_name = $('#select_pet option:selected').text();
    $('#tb_specific_pet_id').val(pet_id);
    $('#tb_specific_pet_name').val(pet_name);

    var oLocation = $('input[name="rb_Location"]:checked');
    var rbLocation = '';
    if (oLocation.length > 0) {
        rbLocation = $(oLocation).val();
    }

    if (rbLocation == '') return;

    var petSpan = $('#div_pet_list_' + rbLocation + ' span[data-id="' + pet_id + '"]');
    if (petSpan.length == 0) return;

    $('#img-select-pet-2-2').attr('src', $(petSpan).attr('data-Photo1'));
    $('#td-select-pet-2-2').toggle(true);

    $('#a-select-pet-2-2').attr('data-PetID', pet_id);
    $('#a-select-pet-2-2').attr('href', '/Pet/' + pet_id);
    var sARN = $(petSpan).attr('data-ARN');
    if (sARN + '' != '') {
        $('#tb_specific_pet_id').val('ARN: ' + sARN + ', Pet ID: ' + pet_id);
    }
    else {
        $('#tb_specific_pet_id').val('Pet ID: ' + pet_id);
    }

}

function cmsFormGenericFormatBirthDate(myDateOfBirth) {
    var myDateOfBirthMonth = myDateOfBirth.getMonth();
    var myDateOfBirthDay = myDateOfBirth.getDay();
    var sMonth = myDateOfBirthMonth;


    if (myDateOfBirthMonth < 10) sMonth = '0' + myDateOfBirthMonth

    var sDay = myDateOfBirthDay;
    if (myDateOfBirthDay < 10) sDay = '0' + myDateOfBirthDay

    return sMonth + '-' + sDay + '-' + myDateOfBirth.getFullYear();
}

function cmsGALogFormGenericEvent_View(pUrl) {
    var eventCategory = 'Form';
    var eventAction = 'View';
    var eventLabel = pUrl;
    if (eventLabel.indexOf('/') != 0) {
        eventLabel = '/' + eventLabel;
    }

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogFormGenericEvent_Submit(pUrl) {
    var eventCategory = 'Form';
    var eventAction = 'Submit';
    var eventLabel = pUrl;
    if (eventLabel.indexOf('/') != 0) {
        eventLabel = '/' + eventLabel;
    }

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogFormGenericEvent_Success(pUrl) {
    var eventCategory = 'Form';
    var eventAction = 'Success';
    var eventLabel = pUrl;
    if (eventLabel.indexOf('/') != 0) {
        eventLabel = '/' + eventLabel;
    }

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogFormGenericEvent_Error(pUrl, pLabel) {
    var eventCategory = 'Form-' + pUrl;
    var eventAction = 'Error'; // View, Submit, Edit, Error
    var eventLabel = pLabel;

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogFormGenericEvent_Edit(pUrl, pLabel) {
    var eventCategory = 'Form-' + pUrl;
    var eventAction = 'Edit';
    var eventLabel = pLabel;

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsCalculateAge(dateString) {
    var today = new Date();
    var birthDate = new Date(dateString);
    var age = today.getFullYear() - birthDate.getFullYear();
    var m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }

    if (birthDate.getFullYear() == today.getFullYear() && birthDate.getMonth() == today.getMonth() && birthDate.getDay() == today.getDay() + 1) {
        age--;
    }

    return age;
}

function cmsCalculateDuration(p) {
    var d1 = new Date(p.DateString);
    var d2 = new Date(); //to date yyyy-MM-dd (taken currentdate)
    var Months = d2.getMonth() - d1.getMonth();
    var Years = d2.getFullYear() - d1.getFullYear();
    var Days = d2.getDate() - d1.getDate();
    Months = (d2.getMonth() + 12 * d2.getFullYear()) - (d1.getMonth() + 12 * d1.getFullYear());
    var MonthOverflow = 0;
    if (Months - (Years * 12) < 0)
        MonthOverFlow = -1;
    else
        MonthOverFlow = 1;

    if (MonthOverFlow < 0) Years = Years - 1; Months = Months - (Years * 12);

    var LastDayOfMonth = new Date(d2.getFullYear(), d2.getMonth() + 1, 0, 23, 59, 59);
    LastDayOfMonth = LastDayOfMonth.getDate();

    if (MonthOverFlow < 0 && (d1.getDate() > d2.getDate())) {
        Days = LastDayOfMonth + (d2.getDate() - d1.getDate()) - 1;
    }
    else
        Days = d2.getDate() - d1.getDate();

    if (Days < 0)
        Months = Months - 1;

    var l = new Date(d2.getFullYear(), d2.getMonth(), 0);
    var l1 = new Date(d1.getFullYear(), d1.getMonth() + 1, 0);

    if (Days < 0) {
        if (l1 > l)
            Days = l1.getDate() + Days;
        else
            Days = l.getDate() + Days;
    }

    p.Years = Years;
    p.Months = Months;
    p.Days = Days;
    p.Age = cmsCalculateAge(p.DateString);
    return p;
}

function cmsIsDate(p) {
    var d;
    if (p.indexOf('-') > 0)
    {
        d = new Date(p.replace("-", "/"));
    }
    else {
        d = new Date(p);
    }

    try {
        if (Object.prototype.toString.call(d) !== "[object Date]")
            return false;
        return !isNaN(d.getTime());
    }
    catch (Error) {
        return false;
    }
}

//END 2014-07-18 

function cmsTwinkleMenu(p) {
    try {
        if (cmsTwinkleMenuIconClickCount > cmsTwinkleMenuIconClickCountMax) return;
        if (cmsTwinkleCount > cmsTwinkleMax) return;
    }
    catch (Error) {

    }

    cmsTwinkleIn = true;

    var xoptions = {
        "effect": "splash",
        "effectOptions": {
            "color": "rgba(245,7,128,0.5)",
            "radius": 75
        },
        "callback": function() {
            cmsTwinkleIn = false;
        }
    };

    $(p).twinkle(xoptions);

    cmsTwinkleIn = false;
}

function cmsTwinkleOnPageLoadTimerInit() {
    cmsTwinkleOnPageLoadTimer = setTimeout('cmsTwinkleOnPageLoadTimerStrike();', cmsTwinkleOnPageLoadTimerInterval)
}

function cmsTwinkleOnPageLoadTimerStrike() {
    cmsTwinkleCount++;

    if (cmsTwinkleCount > cmsTwinkleMax)
    {
        cmsTwinkleOnPageLoadTimerClear();
    }
    else
    {
        cmsTwinkleMenu('section.right-small');
        cmsTwinkleOnPageLoadTimer = setTimeout('cmsTwinkleOnPageLoadTimerStrike();', cmsTwinkleOnPageLoadTimerInterval)
    }
}

function cmsTwinkleOnPageLoadTimerClear() {
    clearTimeout(cmsTwinkleOnPageLoadTimer);
}


function cmsAlumniRewardsJoin(t) {

    var topicID = $('#cms-page-StatusCode').attr('data-topicid');
    var topic = $('#cms-page-StatusCode').attr('data-topic');

    $.ajax({
        url: '/Ajax/AlumniRewardsJoin?topic=' + topic + '&topicid=' + topicID,
        async: false,
        cache: false,
        type: 'POST',
        success: function (data) {
            if (data.HasError)
            {
                cmsShowStatus('#cms-page-StatusCode', 'cms-error', data.StatusText);
            }
            else
            {
                $('#form-fs1').toggle(false);
                $('#cms-search-results-Adoption').toggle(false);
                $('#cms-search-results-Adoptee').toggle(false);
                $('#cms-search-results-Adopter').toggle(false);
                $('#cms-page-StatusCode').attr('data-topicid', '');
                $('#cms-page-StatusCode').attr('data-topic', '');
                cmsShowStatus('#cms-page-StatusCode', 'cms-success', data.StatusText);
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert('An unexpected error occurred: ' + xhr + ' ' + thrownError);
            $('#cms-search-results-Adoptee').toggle(false);
            $('#cms-search-results-Adopter').toggle(false);
            $('#cms-page-StatusCode').attr('data-topicid', '');
            $('#cms-page-StatusCode').attr('data-topic', '');
            cmsShowStatus('#cms-page-StatusCode', 'cms-error', 'An unexpected error occurred: ' + xhr + ' ' + thrownError);
        }

    });
}

function cmsAlumniRewardsRenew(p)
{

    //div-alumni-rewards-active

    $.ajax({
        url: '/Ajax/AlumniRewardsRenew',
        async: false,
        cache: false,
        type: 'POST',
        success: function (data) {
            if (data.HasError) {
                cmsShowStatus('#cms-page-StatusCode', 'cms-error', status.StatusText);
            }
            else
            {
                $('#div-alumni-rewards-expired').toggle(false);
                $('#div-alumni-rewards-active').toggle(true);
                $('#div-alumni-rewards-active-expire-date').text(data.TopicValue);
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert('An unexpected error occurred: ' + xhr + ' ' + thrownError);
            cmsShowStatus('#cms-page-StatusCode', 'cms-success', 'An unexpected error occurred: ' + xhr + ' ' + thrownError);
        }
    });
}