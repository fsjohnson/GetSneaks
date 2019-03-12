
function cmsForumSubjectSeriesChangeGlobalSearchClick() {
    $('#a-globalsearch').attr('onclick', 'cmsForumSubjectSeriesGlobalSearchClick(this);return false;');
}


function cmsForumRepliesSeriesChangeGlobalSearchClick() {
    $('#a-globalsearch').attr('onclick', 'cmsForumRepliesSeriesGlobalSearchClick(this);return false;');
    
}

function cmsForumSubjectSeriesGlobalSearchClick() {
    $('#msg-forum-subject-series').attr('data-cms-filter', cms_msgs_filter_with_keyword);
    $('#msg-forum-subject-series').attr('data-cms-keyword', $('#globalsearchfield').val().trim());
    $('#forum-msg-filter-keyword-link').click();
}

function cmsForumRepliesSeriesGlobalSearchClick() {
    $('#msg-forum-replies-series').attr('data-cms-filter', cms_msgs_filter_with_keyword);
    $('#msg-forum-replies-series').attr('data-cms-keyword', $('#globalsearchfield').val().trim());
    $('#forum-msg-filter-keyword-link').click();
}

function cmsMsgDisableLink(p) {
    $(p).attr('href', '#');
    $(p).attr('onclick', 'return false;');
    $(p).css('color', '#999999');
    $(p).css('cursor', 'not-allowed');
    $(p).on("click", function(e){
        e.preventDefault();
        return false;
    });
}

function cmsContentMsgSeriesSet() {
    var newHtml = cmsContentMsgSeriesGet($('#content-msg-series').attr('data-cms-id'), $('#content-msg-series').attr('data-cms-filter'), $('#content-msg-series').attr('data-cms-page'));
    $('#content-msg-series').html(newHtml);
    //cmsSelectiveTz1('#content-msg-series');
    //cmsScrollToTopOfContentMsgs();
}

function cmsContentMsgSeriesGet(topicID, filter, page) {
    var cmsContentMsgSeriesReturn = '';

    $.ajax({
        url: '/Msg/Content/Series?topicID=' + topicID + '&filter=' + filter + '&page=' + page,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'html',
        success: function (data) {
            cmsContentMsgSeriesReturn = data;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert('An error occurred: ' + xhr + ', ' + thrownError);
            return '';
        }
    });

    return cmsContentMsgSeriesReturn;
}

function cmsContentMsgSeriesPageClicked(msgPage) {
    $('#content-msg-series').attr('data-cms-page', msgPage);
    cmsContentMsgSeriesSet();
    return;
}

function cmsContentMsgSeriesFilterChanged(p) {
    $('#content-msg-series').attr('data-cms-filter',msgFilter = $(p).val());
    cmsContentMsgSeriesSet();
    return;
}

function cmsContentMsgSeriesPrevious(p) {
    var currentPage = $('#content-msg-series').attr('data-cms-page');
    if (isNAN(parseInt(currentPage))) {
        currentPage = 1;
    }
    else {
        if (currentPage == 1) return;
        currentPage = currentPage--;
        $('#content-msg-series').attr('data-cms-page', currentPage)
    }
    cmsContentMsgSeriesSet();
}

function cmsContentMsgSeriesNext(p) {
    var currentPage = $('#content-msg-series').attr('data-cms-page');
    if (isNAN(parseInt(currentPage))) {
        currentPage = 1;
    }
    else {
        if (currentPage == 1) return;
        currentPage = currentPage++;
        $('#content-msg-series').attr('data-cms-page', currentPage)
    }
    cmsContentMsgSeriesSet();
}


function cmsContentMsgCreate() {
    var form = $('#msg-content-create-form');
    var cmsContentMsgCreate_Return = {};
    cmsContentMsgCreate_Return.HasError = false;
    cmsContentMsgCreate_Return.HasWarning = false;
    cmsContentMsgCreate_Return.StatusCode = 'OK_';
    cmsContentMsgCreate_Return.StatusText = 'Comment submitted.';

    if ($('#Msg_Body').val().length > 4000) {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = '4000 characters or less is permitted.';
        cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
        return false;
    }

    if ($('#Msg_Body').val() == '') {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = 'Message entry is required.';
        cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
        return false;
    }

    if ($('#Msg_Body').val().indexOf('<') > -1) {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = 'HTML markup of any sort is not allowed. Please remove any "<" jor ">" characters from your message.';
        cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
        return false;
    }

    if (!cmsMsgContentScrubCheck($('#Msg_Body').val())) {
        return;
    }

    $.ajax({
        url: '/Msg/Content/Create',
        type: 'POST',
        data: form.serialize(),
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsContentMsgCreate_Return = data;
            if (cmsContentMsgCreate_Return.HasError) {
                cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
                //alert('Unable to submit comment: ' + cmsContentMsgCreate_Return.StatusText);
                return false;
            }
            else {
                $('#Msg_Body').val('')
                $('#Msg_Body').height(20);
                $('#Msg_Body').height($('#Msg_Body').scrollHeight);
                cmsContentMsgCreate_Return.StatusText = 'Your comment has been submitted.';
                cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
                return true;
            }

        },
        error: function (jqXhr, textStatus, errorThrown) {
            cmsContentMsgCreate_Return.StatusText = "Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')";
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {
            
        }
    });
}

function cmsContentMsgSetStatus(pStatus) {
    if (pStatus.HasError || pStatus.HasWarning) {
        $('#cms-MsgBody-Status').html('').fadeIn('slow');
        //$('#cms-MsgBody-Status').fadeOut('slow');
        $('#cms-MsgBody-Status').removeClass('cms-success').removeClass('cms-error').addClass('cms-error');
        $('#cms-MsgBody-Status').html(pStatus.StatusText);
        $('#cms-MsgBody-Status').attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-MsgBody-Status').fadeIn('slow');
    } else {
        //$('#cms-MsgBody-Status').fadeOut('slow');
        $('#cms-MsgBody-Status').html('').fadeIn('slow');
        $('#cms-MsgBody-Status').removeClass('cms-success').removeClass('cms-error').addClass('cms-success');
        $('#cms-MsgBody-Status').html(pStatus.StatusText);
        $('#cms-MsgBody-Status').attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-MsgBody-Status').css('display', '');
        $('#cms-MsgBody-Status').fadeIn('slow');
    }
}

function cmsContentMsgFormBodySetKeyUp() {
    $('#msg-content-create-form').on('keyup', 'textarea', function () {
        $(this).height(0);
        $(this).height(this.scrollHeight);
    });
    $('#msg-content-create-form').find('textarea').keyup();
}


//2014-08-01
function cmsContentMsgSidebarCreate() {
    var formSelector = '#msg-content-create-form';
    var form = $(formSelector);

    var cmsContentMsgCreate_Return = {};
    cmsContentMsgCreate_Return.HasError = false;
    cmsContentMsgCreate_Return.HasWarning = false;
    cmsContentMsgCreate_Return.StatusCode = 'OK_';
    cmsContentMsgCreate_Return.StatusText = 'Comment submitted.';

    var bodyFld = $(formSelector + ' textarea[name="Msg.Body"]');
    var bodyVal = $(bodyFld).val();

    if (bodyVal.length > 4000) {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = '4000 characters or less is permitted.';
        cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
        return false;
    }

    if (bodyVal == '') {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = 'Message entry is required.';
        cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
        return false;
    }

    if (bodyVal.indexOf('<') > -1) {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = 'HTML markup of any sort is not allowed. Please remove any "<" jor ">" characters from your message.';
        cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
        return false;
    }

    if (!cmsMsgContentScrubCheck(bodyVal)) {
        return;
    }

    $.ajax({
        url: '/Msg/Content/Create2',
        type: 'POST',
        data: form.serialize(),
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsContentMsgCreate_Return = data;
            if (cmsContentMsgCreate_Return.HasError) {
                cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
                //alert('Unable to submit comment: ' + cmsContentMsgCreate_Return.StatusText);
                return false;
            }
            else {
                $(bodyFld).val('')
                $(bodyFld).height(20);
                $(bodyFld).height($(bodyFld).scrollHeight);
                cmsContentMsgCreate_Return.StatusText = 'Your comment has been submitted.';
                cmsContentMsgSetStatus(cmsContentMsgCreate_Return);
                cmsTimeForNextContentSeriesSidebarMsgs();

                return true;
            }

        },
        error: function (jqXhr, textStatus, errorThrown) {
            cmsContentMsgCreate_Return.StatusText = "Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')";
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}

function cmsMsgContentSeriesSidebarLoad(topicID, code, filter, lastChain) {
    var sHtml = cmsContentSeriesSidebarNotLoaded;

    var dateTimeNow = cmsSortableDateTimeMilliseconds(new Date()).replace(':', '-').replace('.', '-').replace(' ', '-');

    var sGetMsgContentSeriesSidebarUrl = '/Msg/Content/Series/Sidebar'
        + '?topicID=' + topicID
        + '&code=' + code
        + '&filter=' + filter
        + '&lastChain=' + lastChain
        + '&ts=' + dateTimeNow;

    var request = $.ajax({
        url: sGetMsgContentSeriesSidebarUrl,
        async: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = cmsContentSeriesSidebarNotLoaded;
        }
    });

    cmsContentSeriesSidebarInfiniteBlock = 1;
    cmsContentSeriesSidebarInViewActive = false;

    $('#msg-content-container').html(sHtml);
    cmsSelectiveTz1('#msg-content-series');

}

function cmsMsgContentSeriesSidebarLikeItem(p) {

    var cmsMsgContentSeriesSidebarLikeItem_Return = {};
    cmsMsgContentSeriesSidebarLikeItem_Return.HasError = false;
    cmsMsgContentSeriesSidebarLikeItem_Return.StatusCode = 'OK_';
    cmsMsgContentSeriesSidebarLikeItem_Return.StatusText = 'You like this comment.';

    var pID = $(p).attr('data-msg-id');

    if ($('#msg-content-series-like-image-' + pID).attr('data-has-liked') == '1') {
        return;
    }


    $.ajax({
        url: '/Msg/Like?TopicID=' + pID,
        type: 'POST',
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsMsgContentSeriesSidebarLikeItem_Return = data;
            if (cmsMsgContentSeriesSidebarLikeItem_Return.HasError) {
                alert('An error occurred, please let us know if this error continues.');
                return false;
            }

            var imgSrc = $('#msg-content-series-like-image-' + pID).attr('src');
            //alert("src = " + imgSrc);

            imgSrc = imgSrc.replace("-outline", "-solid");

            //alert("src = " + imgSrc);

            $('#msg-content-series-like-image-' + pID).attr('src', imgSrc);

            $('#msg-content-series-like-image-' + pID).attr('data-has-liked', '1');

            var likeCount = parseInt($('#msg-content-series-like-span-' + pID).text());
            likeCount++;
            $('#msg-content-series-like-span-' + pID).text(likeCount);

            $('#msg-content-series-like-image-' + pID).attr('alt', 'You like this comment.');
            $('#msg-content-series-like-image-' + pID).attr('title', 'You like this comment.');
            $('#msg-content-series-like-link-' + pID).attr('title', 'You like this comment.');

        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}


function cmsTimeForNextContentSeriesSidebarMsgs() {
    var newHtml = cmsGetNextContentSeriesSidebarMsgs();
    if (newHtml == cmsContentSeriesSidebarNotLoaded) {
        cmsContentSeriesSidebarInViewOn = false;
        //$('#infinite-msgs-pager').unbind('inview');
        //alert('not loaded');
        return;
    }

    //alert(newHtml);
    cmsContentSeriesSidebarInfiniteBlock++;
    newHtml = '<div id="content-series-sidebar-infinite-block-' + cmsContentSeriesSidebarInfiniteBlock + '" style="display:none;">' + newHtml + '</div>';
    $('#msg-content-series').append(newHtml);
    cmsSelectiveTz1('#content-series-sidebar-infinite-block-' + cmsContentSeriesSidebarInfiniteBlock);

    $('#content-series-sidebar-infinite-block-' + cmsContentSeriesSidebarInfiniteBlock).fadeIn('slow');

}

function cmsGetNextContentSeriesSidebarMsgs() {
    var sHtml = cmsContentSeriesSidebarNotLoaded;
    var lastChain = $('#msg-content-series div.msg-content-series-sidebar:last').attr('data-series-chain');
    if (typeof (lastChain) == 'undefined') {
        return cmsContentSeriesSidebarNotLoaded;
    }

    var dateTimeNow = cmsSortableDateTimeMilliseconds(new Date()).replace(':', '-').replace('.', '-').replace(' ', '-');

    var sGetNextContentSeriesMsgsUrl = '/Msg/Content/Series/Sidebar/Items'
        + '?topic=' + $('#msg-content-series').attr('data-cms-topic')
        + '&topicID=' + $('#msg-content-series').attr('data-cms-topicid')
        + '&code=' + $('#msg-content-series').attr('data-cms-code')
        + '&filter=' + $('#msg-content-series').attr('data-cms-filter')
        + '&lastChain=' + lastChain
        + '&ts=' + dateTimeNow;

    var request = $.ajax({
        url: sGetNextContentSeriesMsgsUrl,
        async: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = cmsContentSeriesSidebarNotLoaded;
        }
    });

    return sHtml;
}

//2014-08-01

// updated below
function cmsMsgContentSeriesLikeItem(pID) {

    var cmsMsgContentSeriesLikeItem_Return = {};
    cmsMsgContentSeriesLikeItem_Return.HasError = false;
    cmsMsgContentSeriesLikeItem_Return.StatusCode = 'OK_';
    cmsMsgContentSeriesLikeItem_Return.StatusText = 'You like this comment.';

    if ($('#msg-content-series-like-image-' + pID).attr('data-has-liked') == '1') {
        return;
    }


    $.ajax({
        url: '/Msg/Like?TopicID=' + pID,
        type: 'POST',
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsMsgContentSeriesLikeItem_Return = data;
            if (cmsMsgContentSeriesLikeItem_Return.HasError) {
                alert('An error occurred, please let us know if this error continues.');
                return false;
            }

            var imgSrc = $('#msg-content-series-like-image-' + pID).attr('src');
            //alert("src = " + imgSrc);

            imgSrc = imgSrc.replace("-outline", "-solid");

            //alert("src = " + imgSrc);

            $('#msg-content-series-like-image-' + pID).attr('src', imgSrc);

            $('#msg-content-series-like-image-' + pID).attr('data-has-liked', '1');

            var likeCount = parseInt($('#msg-content-series-like-span-' + pID).text());
            likeCount++;
            $('#msg-content-series-like-span-' + pID).text(likeCount);

            $('#msg-content-series-like-image-' + pID).attr('alt', 'You like this comment.');
            $('#msg-content-series-like-image-' + pID).attr('title', 'You like this comment.');
            $('#msg-content-series-like-link-' + pID).attr('title', 'You like this comment.');

        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}

//2013-11-06
function cmsMsgSeriesLikeItem(pID, pMode) {

    var cmsMsgSeriesLikeItem_Return = {};
    cmsMsgSeriesLikeItem_Return.HasError = false;
    cmsMsgSeriesLikeItem_Return.StatusCode = 'OK_';
    cmsMsgSeriesLikeItem_Return.StatusText = 'You like this.';

    if ($('#msg-' + pMode + '-series-like-image-' + pID).attr('data-has-liked') == '1') {
        return;
    }


    $.ajax({
        url: '/Msg/Like?TopicID=' + pID,
        type: 'POST',
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsMsgSeriesLikeItem_Return = data;
            if (cmsMsgSeriesLikeItem_Return.HasError) {
                alert('An error occurred, please let us know if this error continues.');
                return false;
            }

            var imgSrc = $('#msg-' + pMode + '-series-like-image-' + pID).attr('src');
            //alert("src = " + imgSrc);

            imgSrc = imgSrc.replace("-outline", "-solid");

            //alert("src = " + imgSrc);

            $('#msg-' + pMode + '-series-like-image-' + pID).attr('src', imgSrc);

            $('#msg-' + pMode + '-series-like-image-' + pID).attr('data-has-liked', '1');

            var likeCount = parseInt($('#msg-' + pMode + '-series-like-span-' + pID).text());
            likeCount++;
            $('#msg-' + pMode + '-series-like-span-' + pID).text(likeCount);

            $('#msg-' + pMode + '-series-like-image-' + pID).attr('alt', 'You like this.');
            $('#msg-' + pMode + '-series-like-image-' + pID).attr('title', 'You like this.');
            $('#msg-' + pMode + '-series-like-link-' + pID).attr('title', 'You like this.');

        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}

function cmsMsgSubjectLikeItem(pID, pMode) {

    var cmsMsgSeriesLikeItem_Return = {};
    cmsMsgSeriesLikeItem_Return.HasError = false;
    cmsMsgSeriesLikeItem_Return.StatusCode = 'OK_';
    cmsMsgSeriesLikeItem_Return.StatusText = 'You like this.';

    if ($('#msg-forum-subject-like-image-' + pID).attr('data-has-liked') == '1') {
        return;
    }

    $.ajax({
        url: '/Msg/Like?TopicID=' + pID,
        type: 'POST',
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsMsgSeriesLikeItem_Return = data;
            if (cmsMsgSeriesLikeItem_Return.HasError) {
                alert('An error occurred, please let us know if this error continues.');
                return false;
            }

            var imgSrc = $('#msg-forum-subject-like-image-' + pID).attr('src');
            //alert("src = " + imgSrc);

            imgSrc = imgSrc.replace("-outline", "-solid");

            //alert("src = " + imgSrc);

            $('#msg-forum-subject-like-image-' + pID).attr('src', imgSrc);

            $('#msg-forum-subject-like-image-' + pID).attr('data-has-liked', '1');

            var likeCount = parseInt($('#msg-forum-subject-like-span-' + pID).text());
            likeCount++;
            $('#msg-forum-subject-like-span-' + pID).text(likeCount);

            $('#msg-forum-subject-like-image-' + pID).attr('alt', 'You like this.');
            $('#msg-forum-subject-like-image-' + pID).attr('title', 'You like this.');
            $('#msg-forum-subject-like-link-' + pID).attr('title', 'You like this.');

        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}


function cmsMsgFlag(p, pID) {

    var cmsMsgSeriesFlagItem_Return = {};
    cmsMsgSeriesFlagItem_Return.HasError = false;
    cmsMsgSeriesFlagItem_Return.StatusCode = 'OK_';
    cmsMsgSeriesFlagItem_Return.StatusText = 'You flagged this.';

    if ($(p).attr('data-has-flagged') == '1') {
        return;
    }

    if (!confirm('Flagging this item will alert us to possible inappropriate content. Do you want to flag this item for review?')) return;

    $.ajax({
        url: '/Msg/Flag?TopicID=' + pID,
        type: 'POST',
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsMsgSeriesFlagItem_Return = data;
            if (cmsMsgSeriesFlagItem_Return.HasError) {
                alert('An error occurred, please let us know if this error continues.');
                return false;
            }

            $(p).parent().toggle(false);

        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}

function cmsMsgSeriesFlagItem(pID) {

    var cmsMsgSeriesFlagItem_Return = {};
    cmsMsgSeriesFlagItem_Return.HasError = false;
    cmsMsgSeriesFlagItem_Return.StatusCode = 'OK_';
    cmsMsgSeriesFlagItem_Return.StatusText = 'You flagged this.';

    if ($('#msg-series-flagged-image-' + pID).attr('data-has-flagged') == '1') {
        return;
    }


    $.ajax({
        url: '/Msg/Flag?TopicID=' + pID,
        type: 'POST',
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsMsgSeriesFlagItem_Return = data;
            if (cmsMsgSeriesFlagItem_Return.HasError) {
                alert('An error occurred, please let us know if this error continues.');
                return false;
            }

            var imgSrc = $('#msg-series-flagged-image-' + pID).attr('src');
            //alert("src = " + imgSrc);

            imgSrc = imgSrc.replace("-outline", "-solid");

            //alert("src = " + imgSrc);

            $('#msg-series-flagged-image-' + pID).attr('src', imgSrc);

            $('#msg-series-flagged-image-' + pID).attr('data-has-flagged', '1');

            var flaggedCount = parseInt($('#msg-series-flagged-span-' + pID).text());
            flaggedCount++;
            $('#msg-series-flagged-span-' + pID).text(flaggedCount);

            $('#msg-series-flagged-image-' + pID).attr('alt', 'You flagged this.');
            $('#msg-series-flagged-image-' + pID).attr('title', 'You flagged this.');
            $('#msg-series-flagged-link-' + pID).attr('title', 'You flagged this.');

        },
        error: function (jqXhr, textStatus, errorThrown) {
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}

function cmsMsgContentScrubCheck(pMessage) {
    if (pMessage + '' == '') return true;

    var regex = new RegExp('\\b(' + cmsProfanityList + ')\\b', 'i');
    if (regex.test(pMessage)) {
        return confirm('Your message may contain profanity and may not be published if you continue.  Please double-check your entry.  If you are certain it is free from profanity, click OK to continue, otherwise click Cancel to edit your message.');
    } else {
        return true;
    }
}

function cmsMsgScrubCheck(pMessage) {
    if (pMessage + '' == '') return true;

    var regex = new RegExp('\\b(' + cmsProfanityList + ')\\b', 'i');
    if (regex.test(pMessage)) {
        return confirm('Your message may contain profanity and may not be published if you continue.  Please double-check your entry.  If you are certain it is free from profanity, click OK to continue, otherwise click Cancel to edit your message.');
    } else {
        return true;
    }
}

// forum subject
function cmsForumSubjectsFormBodySetKeyUp() {
    $('#msg-forum-subject-create-form').on('keyup', 'textarea', function () {
        $(this).height(0);
        $(this).height(this.scrollHeight);
    });
    $('#msg-forum-subject-create-form').find('textarea').keyup();
}

function cmsMsgForumSubjectSetStatus(pStatus) {
    if (pStatus.HasError || pStatus.HasWarning) {
        $('#cms-msg-forum-subject-create-Status').html('').fadeIn('slow');
        $('#cms-msg-forum-subject-create-Status').removeClass('cms-success').removeClass('cms-error').addClass('cms-error');
        $('#cms-msg-forum-subject-create-Status').html(pStatus.StatusText);
        $('#cms-msg-forum-subject-create-Status').attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-msg-forum-subject-create-Status').fadeIn('slow');
    } else {
        $('#cms-msg-forum-subject-create-Status').html('').fadeIn('slow');
        $('#cms-msg-forum-subject-create-Status').removeClass('cms-success').removeClass('cms-error').addClass('cms-success');
        $('#cms-msg-forum-subject-create-Status').html(pStatus.StatusText);
        $('#cms-msg-forum-subject-create-Status').attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-msg-forum-subject-create-Status').css('display', '');
        $('#cms-msg-forum-subject-create-Status').fadeIn('slow');
    }
}

/* BB */
function cmsGetForumSubjectByID(pID) {
    var sHtml = sNotLoaded;

    var sGetForumReplyUrl = '/Msg/Forum/SubjectByID/' + pID;

    var request = $.ajax({
        url: sGetForumReplyUrl,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
            //alert(sHtml);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = sNotLoaded;
        }
    });

    return sHtml;
}

function cmsGetForumSubjectByChain(pChain) {
    var sHtml = sNotLoaded;

    var sGetForumReplyUrl = '/Msg/Forum/SubjectByChain/' + pChain;

    var request = $.ajax({
        url: sGetForumReplyUrl,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
            //alert(sHtml);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = sNotLoaded;
        }
    });

    return sHtml;
}

function cmsMsgForumSubjectCreate() {
    var form = $('#msg-forum-subject-create-form');
    var cmsForumMsgCreate_Return = {};
    cmsForumMsgCreate_Return.HasError = false;
    cmsForumMsgCreate_Return.HasWarning = false;
    cmsForumMsgCreate_Return.StatusCode = 'OK_';
    cmsForumMsgCreate_Return.StatusText = 'Topic submitted.';

    if ($(form).find('textarea.msg-title').val().length > 400) {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = '400 characters or less is permitted.';
        cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);
        $(form).find('textarea.msg-title').focus();
        return false;
    }

    if ($(form).find('textarea.msg-title').val() == '') {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = 'Topic Title is required.';
        cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);
        $(form).find('textarea.msg-title').focus();
        return false;
    }

    if ($(form).find('textarea.msg-title').val().indexOf('<') > -1) {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = 'HTML markup of any sort is not allowed. Please remove any "<" jor ">" characters from your entry.';
        cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);
        $(form).find('textarea.msg-title').focus();
        return false;
    }

    if (!cmsMsgScrubCheck($(form).find('textarea.msg-title').val())) {
        return;
    }

    if ($(form).find('textarea.msg-body').val().length > 4000) {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = '4000 characters or less is permitted.';
        $(form).find('textarea.msg-body').focus();
        cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);
        return false;
    }

    if ($(form).find('textarea.msg-body').val() == '') {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = 'Topic entry is required.';
        cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);
        $(form).find('textarea.msg-body').focus();
        return false;
    }

    if ($(form).find('textarea.msg-body').val().indexOf('<') > -1) {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = 'HTML markup of any sort is not allowed. Please remove any "<" jor ">" characters from your entry.';
        cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);
        $(form).find('textarea.msg-body').focus();
        return false;
    }

    if (!cmsMsgScrubCheck($(form).find('textarea.msg-body').val())) {
        return;
    }

    $.ajax({
        url: '/Msg/Forum/Subject/Create',
        type: 'POST',
        data: form.serialize(),
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsForumMsgCreate_Return = data;
            if (cmsForumMsgCreate_Return.HasError) {
                cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);
                //alert('Unable to submit comment: ' + cmsForumMsgCreate_Return.StatusText);
                return false;
            }
            else {
                $(form).find('textarea.msg-body').val('')
                $(form).find('textarea.msg-body').height(20);
                $(form).find('textarea.msg-body').height($(form).find('textarea.msg-body').scrollHeight);

                $(form).find('textarea.msg-title').val('')
                $(form).find('textarea.msg-title').height(20);
                $(form).find('textarea.msg-title').height($(form).find('textarea.msg-title').scrollHeight);

                cmsForumMsgCreate_Return.StatusText = "Your topic has been saved.";
                cmsMsgForumSubjectSetStatus(cmsForumMsgCreate_Return);

                var newReplyHtml = cmsGetForumSubjectByID(cmsForumMsgCreate_Return.TopicID);
                $('#msg-forum-subject-series').prepend(newReplyHtml);

                var aLink = $('#msg-forum-subject-series div[data-msg-id="' + cmsForumMsgCreate_Return.TopicID + '"] div.msg-forum-subject-series-title a');
                var aLinkHref = $(aLink).attr('href');
                aLinkHref = aLinkHref.replace('/Forum/Subject/', '/Forum/' + cms_url + '/Subject/');
                $(aLink).attr('href', aLinkHref);

                $('#msg-forum-subject-series div[data-msg-id="' + cmsForumMsgCreate_Return.TopicID + '"] div.msg-forum-subject-series-profile-replies a').attr('href', aLinkHref);
                
                cmsSelectiveTz1('#msg-forum-subject-series div[data-msg-id="' + cmsForumMsgCreate_Return.TopicID + '"]');

                return true;
            }

        },
        error: function (jqXhr, textStatus, errorThrown) {
            cmsForumMsgCreate_Return.StatusText = "Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')";
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {

        }
    });
}

function cmsTimeForNextForumSubjectSeries() {
    var newHtml = cmsGetNextForumSubjectSeriesMsgs();
    if (newHtml == sNotLoaded) {
        $('#infinite-msgs-forum-subject-pager').unbind('inview');
        return;
    }

    infiniteBlock++;
    newHtml = '<div id="infinite-msgs-forum-subject-pager-' + infiniteBlock + '" style="display:none;">' + newHtml + '</div>';
    $('#msg-forum-subject-series').append(newHtml);
    cmsSelectiveTz1('#msg-forum-subject-series');
    $('#infinite-msgs-forum-subject-pager-' + infiniteBlock).fadeIn('slow');

}

function cmsGetNextForumSubjectSeriesMsgs() {
    var sHtml = sNotLoaded;
    var lastSeriesItem = $('#msg-forum-subject-series div.msg-forum-subject-series:last');
    var lastChain = 0;
    if (lastSeriesItem.length > 0) {
        lastChain = $(lastSeriesItem).attr('data-series-chain');
    }

    var sGetNextForumSubjectSeriesMsgsUrl = '/Msg/Forum/Subjects/Items'
        + '?topic=' + $('#msg-forum-subject-series').attr('data-cms-topic')
        + '&topicID=' + $('#msg-forum-subject-series').attr('data-cms-topicid')
        + '&code=' + $('#msg-forum-subject-series').attr('data-cms-code')
        + '&order=' + $('#msg-forum-subject-series').attr('data-cms-order')
        + '&filter=' + $('#msg-forum-subject-series').attr('data-cms-filter')
        + '&keyword=' + $('#msg-forum-subject-series').attr('data-cms-keyword')
        + '&lastChain=' + lastChain;

    var request = $.ajax({
        url: sGetNextForumSubjectSeriesMsgsUrl,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
            //alert(sHtml);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = sNotLoaded;
        }
    });

    return sHtml;
}

function cmsMsgForumSubjectFilter(p) {

    var pFilter = $(p).attr('data-cms-filter');

    $('#infinite-msgs-forum-subject-pager').unbind('inview');

    $('#msg-forum-subject-series').attr('data-cms-filter', pFilter);
    $('#msg-forum-subject-series').empty();
    $('#msg-forum-subject-series').attr('data-cms-lastChain', 0);

    cmsTimeForNextForumSubjectSeries();

    $('#forum-msg-filter a').removeClass('active');
    $(p).addClass('active');

    $('#infinite-msgs-forum-subject-pager').bind('inview', function (event, visible) {
        if (visible == true) {
            cmsTimeForNextForumSubjectSeries();
        }
    });

}


// forum reply
function cmsForumRepliesFormBodySetKeyUp() {
    $('#msg-forum-replies-create-form').on('keyup', 'textarea', function () {
        $(this).height(0);
        $(this).height(this.scrollHeight);
    });
    $('#msg-forum-replies-create-form').find('textarea').keyup();
}

function cmsMsgForumRepliesSetStatus(pStatus) {
    if (pStatus.HasError || pStatus.HasWarning) {
        $('#cms-msg-forum-replies-create-Status').html('').fadeIn('slow');
        $('#cms-msg-forum-replies-create-Status').removeClass('cms-success').removeClass('cms-error').addClass('cms-error');
        $('#cms-msg-forum-replies-create-Status').html(pStatus.StatusText);
        $('#cms-msg-forum-replies-create-Status').attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-msg-forum-replies-create-Status').fadeIn('slow');
    } else {
        $('#cms-msg-forum-replies-create-Status').html('').fadeIn('slow');
        $('#cms-msg-forum-replies-create-Status').removeClass('cms-success').removeClass('cms-error').addClass('cms-success');
        $('#cms-msg-forum-replies-create-Status').html(pStatus.StatusText);
        $('#cms-msg-forum-replies-create-Status').attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-msg-forum-replies-create-Status').css('display', '');
        $('#cms-msg-forum-replies-create-Status').fadeIn('slow');
    }
}

function cmsMsgForumRepliesCreate() {
    var form = $('#msg-forum-replies-create-form');
    var cmsForumMsgCreate_Return = {};
    cmsForumMsgCreate_Return.HasError = false;
    cmsForumMsgCreate_Return.HasWarning = false;
    cmsForumMsgCreate_Return.StatusCode = 'OK_';
    cmsForumMsgCreate_Return.StatusText = 'Reply submitted.';


    if ($(form).find('textarea.msg-body').val().length > 4000) {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = '4000 characters or less is permitted.';
        $(form).find('textarea.msg-body').focus();
        cmsMsgForumRepliesSetStatus(cmsForumMsgCreate_Return);
        return false;
    }

    if ($(form).find('textarea.msg-body').val() == '') {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = 'Reply entry is required.';
        cmsMsgForumRepliesSetStatus(cmsForumMsgCreate_Return);
        $(form).find('textarea.msg-body').focus();
        return false;
    }

    if ($(form).find('textarea.msg-body').val().indexOf('<') > -1) {
        cmsForumMsgCreate_Return.HasError = true;
        cmsForumMsgCreate_Return.StatusText = 'HTML markup of any sort is not allowed. Please remove any "<" jor ">" characters from your entry.';
        cmsMsgForumRepliesSetStatus(cmsForumMsgCreate_Return);
        $(form).find('textarea.msg-body').focus();
        return false;
    }

    if (!cmsMsgScrubCheck($(form).find('textarea.msg-body').val())) {
        return;
    }


    $.ajax({
        url: '/Msg/Forum/Reply/Create',
        type: 'POST',
        data: form.serialize(),
        dataType: 'json',
        async: false,
        success: function (data) {
            cmsForumMsgCreate_Return = data;
            if (cmsForumMsgCreate_Return.HasError) {
                cmsMsgForumRepliesSetStatus(cmsForumMsgCreate_Return);
                //alert('Unable to submit comment: ' + cmsForumMsgCreate_Return.StatusText);
                return false;
            }
            else {
                $(form).find('textarea.msg-body').val('')
                $(form).find('textarea.msg-body').height(20);
                $(form).find('textarea.msg-body').height($(form).find('textarea.msg-body').scrollHeight);

                cmsForumMsgCreate_Return.StatusText = "Your reply has been saved.";
                cmsMsgForumRepliesSetStatus(cmsForumMsgCreate_Return);

                var newReplyHtml = cmsGetForumReplyByID(cmsForumMsgCreate_Return.TopicID);
                $('#msg-forum-replies-series').prepend(newReplyHtml);

                /*
                var newReplyParsed = $.parseHtml('<div>' + newReplyHtml + '</div>');
                var newDiv = $(newreplyParsed).find('div.msg-forum-replies-series');
                if (newDiv.length > 0) {
                    if (!isNaN(parseInt($(newDiv).attr('data-series-chain'))))
                    {
                            
                    }
                }
                */

                cmsSelectiveTz1('#msg-forum-replies-series div[data-msg-id="' + cmsForumMsgCreate_Return.TopicID + '"]');

                return true;
            }

        },
        error: function (jqXhr, textStatus, errorThrown) {
            cmsForumMsgCreate_Return.StatusText = "Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')";
            alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
        },
        complete: function () {
            
        }
    });
}

function cmsGetForumReplyByID(pID) {
    var sHtml = sNotLoaded;
    
    var sGetForumReplyUrl = '/Msg/Forum/Subject/Reply/' + pID;

    var request = $.ajax({
        url: sGetForumReplyUrl,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
            //alert(sHtml);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = sNotLoaded;
        }
    });

    return sHtml;
}

function cmsGetForumReplyByChain(pChain) {
    var sHtml = sNotLoaded;

    var sGetForumReplyUrl = '/Msg/Forum/Subject/Reply/' + pChain;

    var request = $.ajax({
        url: sGetForumReplyUrl,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
            //alert(sHtml);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = sNotLoaded;
        }
    });

    return sHtml;
}

function cmsTimeForNextForumRepliesSeries() {
    var newHtml = cmsGetNextForumRepliesSeriesMsgs();
    if (newHtml == sNotLoaded) {
        $('#infinite-msgs-forum-replies-pager').unbind('inview');
        return;
    }

    infiniteBlock++;
    newHtml = '<div id="infinite-msgs-forum-replies-pager-' + infiniteBlock + '" style="display:none;">' + newHtml + '</div>';
    $('#msg-forum-replies-series').append(newHtml);
    cmsSelectiveTz1('#msg-forum-replies-series');
    $('#infinite-msgs-forum-replies-pager-' + infiniteBlock).fadeIn('slow');

}

function cmsGetNextForumRepliesSeriesMsgs() {
    var sHtml = sNotLoaded;
    var lastSeriesItem = $('#msg-forum-replies-series div.msg-forum-replies-series:last');
    var lastChain = 0;
    if (lastSeriesItem.length > 0) {
        lastChain = $(lastSeriesItem).attr('data-series-chain');
    }

    var sGetNextForumRepliesSeriesMsgsUrl = '/Msg/Forum/Subject/Replies'
        + '?topic=' + $('#msg-forum-replies-series').attr('data-cms-topic')
        + '&topicID=' + $('#msg-forum-replies-series').attr('data-cms-topicid')
        + '&code=' + $('#msg-forum-replies-series').attr('data-cms-code')
        + '&order=' + $('#msg-forum-replies-series').attr('data-cms-order')
        + '&filter=' + $('#msg-forum-replies-series').attr('data-cms-filter')
        + '&keyword=' + $('#msg-forum-replies-series').attr('data-cms-keyword')
        + '&lastChain=' + lastChain;

    var request = $.ajax({
        url: sGetNextForumRepliesSeriesMsgsUrl,
        async: false,
        cache: false,
        type: 'GET',
        dataType: 'html',
        success: function (data) {
            sHtml = data;
            //alert(sHtml);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            //alert('error ');
            sHtml = sNotLoaded;
        }
    });

    return sHtml;
}

function cmsMsgForumRepliesFilter(p) {

    var pFilter = $(p).attr('data-cms-filter');

    $('#infinite-msgs-forum-replies-pager').unbind('inview');

    $('#msg-forum-replies-series').attr('data-cms-filter', pFilter);
    $('#msg-forum-replies-series').empty();
    $('#msg-forum-replies-series').attr('data-cms-lastChain', 0);

    cmsTimeForNextForumRepliesSeries();

    $('#forum-msg-filter a').removeClass('active');
    $(p).addClass('active');

    $('#infinite-msgs-forum-replies-pager').bind('inview', function (event, visible) {
        if (visible == true) {
            cmsTimeForNextForumRepliesSeries();
        }
    });

}

