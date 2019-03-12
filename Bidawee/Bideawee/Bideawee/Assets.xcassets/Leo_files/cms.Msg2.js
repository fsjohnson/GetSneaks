
function cmsTimeForNextContentSeriesMsgs2(uid) {
    var uid2 = '';
    if (uid != '') {
        uid2 = '-' + uid;
    }

    var sNotLoaded = '<!-- not loaded -->';
    var infiniteBlock = parseInt($('#infinite-msgs-pager' + uid2).attr('data-block'));

    var newHtml = cmsGetNextContentSeriesMsgs2(uid);
    if (newHtml == sNotLoaded) {
        $('#infinite-msgs-pager' + uid2).unbind('inview');
        //alert('not loaded');
        return;
    }

    infiniteBlock++;
    $('#infinite-msgs-pager' + uid2).attr('data-block', infiniteBlock)

    newHtml = '<div id="infinite-block' + uid2 + '-' + infiniteBlock + '" style="display:none;">' + newHtml + '</div>';
    $('#msg-content-series' + uid2).append(newHtml);
    $('#infinite-block' + uid2 + '-' + infiniteBlock).fadeIn('slow');

}

function cmsGetNextContentSeriesMsgs2(uid) {
    var uid2 = '';
    if (uid != '') {
        uid2 = '-' + uid;
    }
    var sNotLoaded = '<!-- not loaded -->';
    var sHtml = sNotLoaded;
    var msgContentSeriesSelector = '#msg-content-series' + uid2;

    var lastChain = $(msgContentSeriesSelector + ' div.msg-content-series:last').attr('data-series-chain');

    var dateTimeNow = cmsSortableDateTimeMilliseconds(new Date()).replace(':', '-').replace('.', '-').replace(' ', '-');

    var sGetNextContentSeriesMsgsUrl = '/Msg/Content/Series/Items'
        + '?topic=' + $(msgContentSeriesSelector).attr('data-cms-topic')
        + '&topicID=' + $(msgContentSeriesSelector).attr('data-cms-topicid')
        + '&code=' + $(msgContentSeriesSelector).attr('data-cms-code')
        + '&filter=' + $(msgContentSeriesSelector).attr('data-cms-filter')
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
            sHtml = sNotLoaded;
        }
    });

    return sHtml;
}

function cmsContentMsgCreate2(uid) {
    var uid2 = '';
    if (uid != '') {
        uid2 = '-' + uid;
    }

    var formSelector = '#msg-content-create-form' + uid2;
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
        cmsContentMsgSetStatus2(uid, cmsContentMsgCreate_Return);
        return false;
    }

    if (bodyVal == '') {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = 'Message entry is required.';
        cmsContentMsgSetStatus2(uid, cmsContentMsgCreate_Return);
        return false;
    }

    if (bodyVal.indexOf('<') > -1) {
        cmsContentMsgCreate_Return.HasError = true;
        cmsContentMsgCreate_Return.StatusText = 'HTML markup of any sort is not allowed. Please remove any "<" jor ">" characters from your message.';
        cmsContentMsgSetStatus2(uid, cmsContentMsgCreate_Return);
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
                cmsContentMsgSetStatus2(uid, cmsContentMsgCreate_Return);
                //alert('Unable to submit comment: ' + cmsContentMsgCreate_Return.StatusText);
                return false;
            }
            else {
                $(bodyFld).val('')
                $(bodyFld).height(20);
                $(bodyFld).height($(bodyFld).scrollHeight);
                //alert('Your comment has been submitted for approval.');
                cmsContentMsgCreate_Return.StatusText = 'Your comment has been submitted for approval.';
                cmsContentMsgSetStatus2(uid, cmsContentMsgCreate_Return);
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

function cmsContentMsgSetStatus2(uid, pStatus) {
    var uid2 = '';
    if (uid != '') {
        uid2 = '-' + uid;
    }


    if (pStatus.HasError || pStatus.HasWarning) {
        $('#cms-MsgBody-Status' + uid2).html('').fadeIn('slow');
        //$('#cms-MsgBody-Status').fadeOut('slow');
        $('#cms-MsgBody-Status' + uid2).removeClass('cms-success').removeClass('cms-error').addClass('cms-error');
        $('#cms-MsgBody-Status' + uid2).html(pStatus.StatusText);
        $('#cms-MsgBody-Status' + uid2).attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-MsgBody-Status' + uid2).fadeIn('slow');
    } else {
        //$('#cms-MsgBody-Status').fadeOut('slow');
        $('#cms-MsgBody-Status' + uid2).html('').fadeIn('slow');
        $('#cms-MsgBody-Status' + uid2).removeClass('cms-success').removeClass('cms-error').addClass('cms-success');
        $('#cms-MsgBody-Status' + uid2).html(pStatus.StatusText);
        $('#cms-MsgBody-Status' + uid2).attr('data-StatusCode', pStatus.StatusCode);
        $('#cms-MsgBody-Status' + uid2).css('display', '');
        $('#cms-MsgBody-Status' + uid2).fadeIn('slow');
    }
}