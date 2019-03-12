
var cem = {
    version: 4.01,
    schemas: ['Content','Entity'],
    basepath: '/',
    verbose: 1,
    schemaCSS: 'cem',
    schemaDOM: 'cem',

    Admin: {},
    Content: {},
    Entity: {},

    fnMoxManAllMediaBrowse: function (pID) {
        moxman.browse({
            relative_urls: true,
            //fields: pID,
            //include_file_pattern: '[.*]',
            document_base_url: '/',
            oninsert: function (args) {
                //console.log(args.focusedFile);
                $('#' + pID).val(args.focusedFile.path);
            }
        });
    },

    fnMoxManAllMediaBrowseFromLabel: function (p) {
        bim.fnMoxManAllMediaBrowse($(p).attr('for'));
    }

};

var cmsVer = 2.9;

var cmsFBLoginScope = 'email,user_location,user_birthday'; //,user_birthday,user_location'; //,publish_actions,publish_stream'; //user_about_me
var cmsHttpProtocol = 'http';
var cmsHttpsProtocol = 'https';

var cmsHttpsHost = 'www.bideawee.org';
var cmsHttpHost = 'www.bideawee.org';
cmsHttpHost = cmsHttpsHost;

var cmsCookieHost = '*.bideawee.org';

/* NEW 2013-10-17 */
var cms_googleID;
var cms_facebookID;
var cms_twitterID;
var cms_addThisID;




var cmsSiteGlobalNotice = '';
var cmsSiteDownForMaintenance = false;

var cmsSitePageViewEnabled = true;
var cmsSitePageViewCookieName = 'Landing0001';
var cmsSitePageViewCookieValue = '';
var cmsSitePageViewRepeatVisitor = false;
var cmsSitePageViewKeepOnTop = '';
var cmsLandingContentPagerClicked = false;
var cmsLandingContentPageScrolled = false;

/* NEW 2013-06-26 */
var cmsEnableLandingVideo = true;
var cmsLandingVideoPlaying = false;

var cmsLanding_RC_Video_Enabled = true;
var cmsLanding_RC_Timeout_Interval_First = 4000;
var cmsLanding_RC_Timeout_Interval = 3000;
var cmsLanding_RC_Timer;
var cmsLanding_RC_DoPlayAll = false;
var cmsLanding_RC_Played_All = false;
/* NEW 2013-06-26 */


var cmsSlideshowTimerEnabled = true;

var cmsEntitySingleSignOnUrl = '';

var cmsEntitySingleSignOnUrlRedirect = '';
if (cmsEntitySingleSignOnUrl != '') {
    cmsHttpsProtocol + '://' + cmsHttpsHost + '/extrd.html';
}

var cmsEntitySingleSignOutUrl = '';
var cmsEntitySingleSignOnProfileUrlRedirect
if (cmsEntitySingleSignOnProfileUrlRedirect != '') {
    cmsEntitySingleSignOnProfileUrlRedirect = cmsHttpsProtocol + '://' + cmsHttpsHost + '/blank.html';
}

cms_main_height = '';

var cms_me = {};

var cms_mainScrollPane;
var cms_mainScrollPaneAPI;



/* NEW FORUMS */
var cms_msgs_filter_with_keyword = 0;
var cms_msgs_filter_all = -1;
var cms_msgs_filter_from_last_visit = -2;
var cms_msgs_filter_popular = -3;
var cms_msgs_filter_busiest = -4;

/* mouseover twinkle */
var cmsTwinkleCookieName = 'cms-right-off-canvas-toggle';
var cmsTwinkleCookie = null;

var cmsTwinkleIn = false;
var cmsTwinkleCount = 0;
var cmsTwinkleMax = 7;
var cmsTwinkleMenuIconClickCount = 0;
var cmsTwinkleMenuIconClickCountMax = 3;
var cmsTwinkleOnPageLoadTimer;
var cmsTwinkleOnPageLoadTimerInterval = 3000;

