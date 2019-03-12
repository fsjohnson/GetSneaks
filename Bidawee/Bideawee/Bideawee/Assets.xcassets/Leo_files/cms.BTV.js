
function cmsBTVSetAsVoted(contentMediaID) {
    $('#cms-list').find('#div_youtubethumb_' + contentMediaID).parent().removeClass('btv-voted').addClass('btv-voted');
    $('#button-btv-vote-' + contentMediaID).attr('disabled', 'disabled')
    $('#button-btv-vote-' + contentMediaID).css('color', 'gray');
    $('#button-btv-vote-' + contentMediaID).css('cursor', 'not-allowed');
    $('#button-btv-vote-' + contentMediaID).attr('title', 'You have voted for this video.');
    //$('#button-btv-vote-' + contentMediaID).text('You have voted for this video.');
}

function cmsBTVVote(p) {
    if ($(p).attr('disabled') == 'disabled')
    {
        alert('You have voted for this video.')
        return false;
    }

    var confirmPrompt = 'Vote for this item:\n' + $(p).attr('data-cms-title') + '?';

    if (!confirm(confirmPrompt)) return false;
    contentMediaID = $(p).attr('data-cms-id');

    var voteReturn = cmsContent_SaveVote(contentMediaID);
    if (voteReturn.HasError) {
        alert(voteReturn.StatusText);
        return;
    }

    if (cmsVoteModel == cmsVOTE_FOR_GROUP) {
        cmsCanVote = false;
        cmsMGVotes.push(contentMediaID);
    }
    else {
        cmsMGVotes.push(contentMediaID);
    }

    cmsBTVSetAsVoted(contentMediaID);
    //cmsMediaGalleryItemSetVoting();
}


function cmsBTVPLaylistThumbClick(p) {
    var myID = $(p).attr('data-videoid');
    var myUrl = $(p).attr('data-video-url');
    $(p).css('display', 'none');

    var iframeSrc = myUrl + '&feature=player_detailpage&amp;autoplay=1&amp;rel=0';
    $('#div_youtubeflex_' + myID).css('display', '');
    $('#iframe_youtubevideo_' + myID).attr('src', iframeSrc);
    $('#iframe_youtubevideo_' + myID).css('display', '');
}

function cmsBTVThumbClick(p) {
    var myID = $(p).attr('data-videoid');
    $(p).css('display', 'none');

    var iframeSrc = '//www.youtube.com/embed/' + myID + '?feature=player_detailpage&amp;autoplay=1&amp;rel=0';
    $('#div_youtubeflex_' + myID).css('display', '');
    $('#iframe_youtubevideo_' + myID).attr('src', iframeSrc);
    $('#iframe_youtubevideo_' + myID).css('display', '');
}

function cmsBTVForumSubjectsScrollToTop(vID) {
    var divID = '#btv-playlistitem-' + vID;
    cmsBodyAnimateScrollTop($(divID).offset().top - 10);
    
}

function cmsBTVMsgCountClick(p, loop) {
    var topicID = $(p).attr('data-msg-topicid');
    var code = $(p).attr('data-msg-code');
    var filter = '';
    var lastChain = 0;
    cmsMsgContentSeriesSidebarLoad(topicID, code, filter, lastChain);

    //check if small screen, if so then animate the comment div to top, o/w the off-canvas-wrap to top
    var isSmallScreen = cmsIsSmallScreen();
    var isMediumScreen = cmsIsMediumScreen();
    var isLargeScreen = cmsIsLargeScreen();
    var contentMsgTitle = "Comments";
    var sContentMsgTitle = $(p).attr('data-msg-title') + '';
    if(sContentMsgTitle != 'undefined')
    {
        contentMsgTitle = sContentMsgTitle;
        $('#msg-content-series-sidebar-title').html(contentMsgTitle);
    }

    if (isLargeScreen)
    {
        cmsBodyAnimateScrollTop(0);
        return false;
    }
    else
    {
        // let the href # work
        return true;
    }
}

function cmsSetBTVChannelGetVideoIDFromHash() {
    currentID = window.location.hash.substr(1);
    if (currentID + '' != '') {
        if (currentID.indexOf('.') >= 0) {
            currentID = currentID.substring(currentID.indexOf('.') + 1, currentID.lastIndexOf('.'));
        }
    }
}

