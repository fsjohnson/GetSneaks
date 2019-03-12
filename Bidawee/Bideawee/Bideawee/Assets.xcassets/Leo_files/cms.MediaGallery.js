var cmsMediaGalleryItemIndex = 0;
var cmsMediaGalleryItemCount = 0;

var cmsMGVotes = [];
var cmsCanVote = false;
var cmsVoteModel = '';
var cmsVOTE_FOR_GROUP = 0;
var cmsVOTE_FOR_INDIVIDUAL = 0;
var contentMediaID = null;
var cmsCSSPink = '#F50780';
var galleryUI = null;
var galleryItemID = '';

function cmsGalleryImgOnClick(p1) {
    var p = $(p1).closest('div.text-center').find('a.show-for-small-only');
    cmsGalleryLinkOnClick(p);
    return false;
}


function cmsGalleryLinkOnClick(p) {
    galleryItemID = $(p).closest('div.gallery-list-item').attr('data-cms-id');
    $('#cms-gallery-modal').attr('data-cms-id', galleryItemID);

    if (galleryUI == 'scrapbook-inthehome') {

        //alert('here3 ' + canVoteThisItem);
        var itemLoop = $(p).attr('data-loop');
        $('#cms-gallery-modal').attr('data-loop', itemLoop);
        $('#cms-gallery-modal-image').attr('src', $(p).attr('href'));
        $('#cms-gallery-modal-title').html($(p).html());

        cmsGallerySetVoting();

        $('#cms-gallery-modal').foundation('reveal', 'open');

        //location.hash = '#gallery-list-column-' + galleryItemID;
        //location.hash = '';
        return false;
    }
    else
    {
        window.location = $(p).closest('div.text-center[data-cms-url]').attr('data-cms-url');
        return false;
    }


    return false;
}


function cmsGalleryModalNext(p) {
    var curLoop = $('#cms-gallery-modal').attr('data-loop');
    var nextLoop = parseInt(curLoop) + 1;
    if ($('#cms-gallery-row div.gallery-list-row').find('div.columns').filter('[data-loop = "' + nextLoop + '"]').length == 0) {
        nextLoop = 0;
    }

    var galleryRowLink = $('#cms-gallery-row div.gallery-list-row').find('a[data-loop = "' + nextLoop + '"]');

    $(galleryRowLink).filter(':visible').click();
}

function cmsGalleryModalPrevious(p) {
    var curLoop = $('#cms-gallery-modal').attr('data-loop');
    var prevLoop = parseInt(curLoop) - 1;
    if (prevLoop < 0) {
        prevLoop = $('#cms-gallery-row div.gallery-list-row').find('div.columns').length - 1;
    }

    var galleryRowLink = $('#cms-gallery-row div.gallery-list-row').find('a[data-loop = "' + prevLoop + '"]');

    $(galleryRowLink).filter(':visible').click();
}

function cmsGallerySetVoting() {

    if (!cmsCanVote)
    {
        canVoteThisItem = false;
        $('#cms-gallery-modal div.cms-gallery-modal-vote-row').addClass('hide');
    }
    else
    {
        canVoteThisItem = cmsGalleryItemCanVote(galleryItemID);

        if (canVoteThisItem)
        {
            $('#cms-gallery-modal div.cms-gallery-modal-vote-row').removeClass('hide');
        }
        else
        {
            $('#cms-gallery-modal div.cms-gallery-modal-vote-row').addClass('hide');
        }
    }
}


function cmsGalleryItemCanVote(id) {
    if (!cmsCanVote) return false;
    var voteTest = $.inArray(id, cmsMGVotes);
    if (voteTest == -1) {
        return true;
    } else {
        return false;
    }
}

function cmsGalleryItemVote() {
    
    var confirmPrompt = 'Vote for this item?\n\n' + $('#cms-gallery-modal-title').text() + '\n\n';

    if (!confirm(confirmPrompt)) return false;
    galleryItemID = $('#cms-gallery-modal').attr('data-cms-id');

    var Content_SaveVoteReturn = {};

    var cmsContent_SaveVoteUrl = '/Ajax/Content/SaveVote/' + galleryItemID;

    $.ajax({
        url: cmsContent_SaveVoteUrl,
        async: false,
        cache: false,
        type: 'POST',
        dataType: 'json',
        success: function (json) {
            Content_SaveVoteReturn = json;

            if (cmsVoteModel == cmsVOTE_FOR_GROUP) {
                cmsCanVote = false;
                cmsMGVotes.push(galleryItemID);
            }
            else {
                cmsMGVotes.push(galleryItemID);
            }

            cmsGalleryItemSetAsVoted(galleryItemID);
            cmsGallerySetVoting();
            alert('Thank you, your vote has been saved.');
        },
        error: function (xhr, ajaxOptions, thrownError) {
            Content_SaveVoteReturn.HasError = true;
            Content_SaveVoteReturn.StatusCode = 'ERR_AJAX';
            Content_SaveVoteReturn.StatusText = 'An unexpected error occurred: ' + xhr + ' ' + thrownError;

            alert(Content_SaveVoteReturn.StatusText);
            return;
        }
    });

    
}

function cmsGalleryItemSetAsVoted(contentMediaID) {
    $('#cms-gallery-columns').find('div.gallery-list-item[data-cms-id="' + contentMediaID + '"]').addClass('media-gallery-item-voted'); //.css('border-color', cmsCSSPink);
}

