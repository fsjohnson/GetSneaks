
function cmsDonationDNDReturnToSite(p) {

    if (document.referrer) {
        if (document.referrer.indexOf('bideawee.org') > 0 || document.referrer.indexOf('localhost:') > 0) {
            if (window.location != document.referrer) {
                window.location = document.referrer;
                return false;
            }
            else {
                return true;
            }

        } else {
            return true;
        }
    } else {
        return true;
    }
}


function cmsDonationDNDGetStarted(p) {
    $('#donation-dnd-splash-row').toggle(false);
    $('#donation-dnd-main').toggle(true);
    cmsDonationDNDChoose(p);

}

function cmsDonationDNDChoose(p) {
    if (p != 'cat' && p != 'dog') {
        p = cat;
    }

    $('#donation-dnd-menu-copy-target-cat').toggle(false);
    $('#donation-dnd-menu-copy-target-dog').toggle(false);
    $('#donation-dnd-menu-copy-target-' + p).toggle(true);



    cmsGALogFormDonationDNDEvent_Choose(cms_url, p);

    var sourceContainerHeight = $('#donation-dnd-source-list-' + p).height();
    var itemCount = $('#donation-dnd-source-list-' + p).find('img.donation-dnd-image-' + p).length;
    var itemDiff = 20;
    if (cmsIsSmallScreen()) {
        itemDiff = 25;
    }

    var itemHeight = (sourceContainerHeight / itemCount) - itemDiff;

    if (sourceContainerHeight > 0) {
        $('#donation-dnd-source-list-' + p).find('img.donation-dnd-image-' + p).css('max-height', itemHeight + 'px');
    }



    $('#donation-dnd-main').attr('data-dnd-topic', p);
    $('#donation-dnd-main').attr('data-dnd-amount', $('#donation-dnd-main').attr('data-dnd-amount-' + p));

    $('#donation-dnd-target-none').toggle(false);
    $('#donation-dnd-target-dog').toggle(false);
    $('#donation-dnd-target-cat').toggle(false);
    $('#donation-dnd-target-' + p).toggle(true);
    $('#donation-dnd-target-finish').toggle(false);

    $('#donation-dnd-source-list-dog').toggle(false);
    $('#donation-dnd-source-list-cat').toggle(false);
    $('#donation-dnd-source-list-' + p).toggle(true);

    if (sourceContainerHeight <= 0) {
        sourceContainerHeight = $('#donation-dnd-source-list-' + p).height();
        itemCount = $('#donation-dnd-source-list-' + p).find('img.donation-dnd-image-' + p).length;

        itemHeight = (sourceContainerHeight / itemCount) - itemDiff;

        $('#donation-dnd-source-list-' + p).find('img.donation-dnd-image-' + p).css('max-height', itemHeight + 'px');

        $('#donation-dnd-left-column').height(sourceContainerHeight);
    }

    var currentTotal = parseInt($('#donation-dnd-main').attr('data-dnd-amount-' + p));
    $('#h5-total').attr('data-total', currentTotal);
    $('#h5-total').text('$' + currentTotal.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));
}

function cmsDonationDNDStartOver_Confirm() {
    if (!confirm('Clear your choices and start over?')) {
        return;
    }

    cmsDonationDNDStartOver();
}

function cmsDonationDNDStartOver() {
    $('#donation-dnd-main').toggle(false);
    $('#donation-dnd-splash-row').toggle(true);

    $('#donation-dnd-menu-copy-target-cat').toggle(false);
    $('#donation-dnd-menu-copy-target-dog').toggle(false);


    //$('#donation-dnd-menu-dog').toggle(false);
    //$('#donation-dnd-menu-cat').toggle(false);

    $('#donation-dnd-main').attr('data-dnd-topic', '');
    $('#donation-dnd-main').attr('data-dnd-amount', '0');
    $('#donation-dnd-main').attr('data-dnd-amount-dog', '0');
    $('#donation-dnd-main').attr('data-dnd-amount-cat', '0');

    $('#donation-dnd-target-cat').toggle(false);
    $('#donation-dnd-target-dog').toggle(false);
    $('#donation-dnd-target-none').toggle(true);
    $('#donation-dnd-target-finish').toggle(false);

    $('#donation-dnd-source-list-cat').toggle(false);
    $('#donation-dnd-source-list-dog').toggle(false);

    //$('#donation-dnd-menu-cat').removeClass('donation-dnd-menu-active');
    //$('#donation-dnd-menu-dog').removeClass('donation-dnd-menu-active');

    var currentTotal = parseInt($('#donation-dnd-main').attr('data-dnd-amount'));
    $('#h5-total').attr('data-total', currentTotal);
    $('#h5-total').text('$' + currentTotal.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));

    $('#donation-dnd-target-cat img').remove();
    $('#donation-dnd-target-dog img').remove();
}

function cmsDonationDNDQuit() {
    if (!confirm('Are you sure you want to quit?')) return;

    if ($('#cms-body-toggle').attr('data-cms-has-body') == '1') {
        cmsDonationDNDStartOver();

        $('#cms-donationdnd-main').foundation('reveal', 'close');
        $('div.reveal-modal-bg').remove();

        $('#cms-body-toggle').toggle(true);
    }
    else {
        window.location.href = '/';
    }


    return;
}

function cmsDonationDNDFormCBClick() {

    catTotal = parseInt($('#donation-dnd-cb-cat').val());
    dogTotal = parseInt($('#donation-dnd-cb-dog').val());
    var currentTotal = 0;
    if ($('#donation-dnd-cb-cat').is(':checked')) {
        currentTotal = currentTotal + catTotal;
    }
    if ($('#donation-dnd-cb-dog').is(':checked')) {
        currentTotal = currentTotal + dogTotal;
    }

    $('#h5-total').attr('data-total', currentTotal);
    $('#h5-total').text('$' + currentTotal.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));

    $('label[for="donation-dnd-cb-fb-share"]').text($('label[for="donation-dnd-cb-fb-share"]').attr('data-text').replace('~', $('#h5-total').text()));
}

function cmsDonationDNDGoBack() {

    // $('#donation-dnd-target-dog').toggle(false);
    //$('#donation-dnd-target-cat').toggle(false);
    $('#donation-dnd-target-finish').toggle(false);

    $('#donation-dnd-target-none').toggle(true);

    //$('#donation-dnd-menu-cat').removeClass('donation-dnd-menu-active');
    //$('#donation-dnd-menu-dog').removeClass('donation-dnd-menu-active');

    $('#donation-dnd-cb-cat').removeAttr('checked');
    $('#donation-dnd-cb-dog').removeAttr('checked');

    var currentTotal = 0;
    $('#h5-total').attr('data-total', currentTotal);
    $('#h5-total').text('$' + currentTotal.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));
}

function cmsDonationDNDFinish() {

    $('#donation-dnd-cb-cat').val($('#donation-dnd-main').attr('data-dnd-amount-cat'));
    $('#donation-dnd-cb-dog').val($('#donation-dnd-main').attr('data-dnd-amount-dog'));


    catTotal = parseInt($('#donation-dnd-cb-cat').val());
    dogTotal = parseInt($('#donation-dnd-cb-dog').val());

    if ((catTotal + dogTotal) <= 0) {
        alert("You need to add Pet Props in order to finish.");
        return;
    }

    var donateUrl = $('#a-donation-dnd-menu-gotodonate').attr('data-donate-url');
    var qsParam = '?';
    if (donateUrl.indexOf('?') > 0) {
        qsParam = '&';
    }
    else {
        qsParam = '?';
    }

    if ($('#donation-dnd-main').attr('data-dnd-topic') == 'cat') {
        $('#a-donation-dnd-menu-gotodonate').attr('href', donateUrl + qsParam + 'amount=' + catTotal);
    }
    else if ($('#donation-dnd-main').attr('data-dnd-topic') == 'dog') {
        $('#a-donation-dnd-menu-gotodonate').attr('href', donateUrl + qsParam + 'amount=' + dogTotal);
    }

    cmsDonationDNDFormSave();

    window.location.href = $('#a-donation-dnd-menu-gotodonate').attr('href');
}

function cmsDonationDNDFormSave() {
    // save form info here

    var currentTopic = $('#donation-dnd-main').attr('data-dnd-topic');
    if (currentTopic != 'cat' && currentTopic != 'dog') {
        return;
    }

    $('#FormDonationDND').remove('input');

    var form = $('#FormDonationDND');

    $('#donation-dnd-target-' + currentTopic).find('img.donation-dnd-image-dropped').each(function (index) {
        var imgUrl = $(this).attr('data-cms-url');
        $('<input>').attr({
            type: 'hidden',
            id: currentTopic + '-' + imgUrl + '-' + index,
            name: currentTopic + '-' + imgUrl + '-' + index,
            value: $(this).attr('data-custom0')
        }).appendTo('#FormDonationDND');
    });

    $.ajax({
        url: form.attr('action'),
        type: "POST",
        data: form.serialize(),

        success: function (data) {
            var status = data;

            if (status.HasError) {
                cmsGALogFormDonationDNDEvent_Error(cms_url, status.StatusText);
            } else {
                var successText = status.StatusText;
                $('#iframetracker').attr('src', '/cms/Tracker.ashx?page=' + cms_url + '&action=submitted');
                cmsGALogFormDonationDNDEvent_Success(cms_url);
            }


        },
        error: function (jqXhr, textStatus, errorThrown) {
            //alert(textStatus + ' - ' + jqXhr.responseText + ' - ' + error);
        },
        complete: function () {

        }
    });
}

function cmsDonationDNDFirstOpen() {
    $('#cms-donationdnd-main').foundation('reveal', 'open', {
        url: $('#a-cms-donationdnd-main').attr('href'),
        success: function () {
        }
    });
}


function cmsGALogFormDonationDNDEvent_View(pUrl) {
    var eventCategory = 'DonationDND';
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

function cmsGALogFormDonationDNDEvent_Cancel(pUrl) {
    var eventCategory = 'DonationDND';
    var eventAction = 'Cancel';
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

function cmsGALogFormDonationDNDEvent_Choose(pUrl, pLabel) {
    var eventCategory = 'DonationDND-' + pUrl;
    var eventAction = 'Choose';
    var eventLabel = pLabel;
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

function cmsGALogFormDonationDNDEvent_Submit(pUrl) {
    var eventCategory = 'DonationDND';
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

function cmsGALogFormDonationDNDEvent_Success(pUrl) {
    var eventCategory = 'DonationDND';
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

function cmsGALogFormDonationDNDEvent_Error(pUrl, pLabel) {
    var eventCategory = 'DonationDND-' + pUrl;
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

function cmsGALogFormDonationDNDEvent_DNDAdd(pUrl, pLabel) {
    var eventCategory = 'DonationDND-' + pUrl;
    var eventAction = 'DND-Add';
    var eventLabel = pLabel;

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}

function cmsGALogFormDonationDNDEvent_DNDRemove(pUrl, pLabel) {
    var eventCategory = 'DonationDND-' + pUrl;
    var eventAction = 'DND-Remove';
    var eventLabel = pLabel;

    try {
        if (cms_googleID + '' != '' && cms_googleID + '' != 'undefined') {
            ga('send', 'event', eventCategory, eventAction, eventLabel);
        }
    }
    catch (err)
    { }
}