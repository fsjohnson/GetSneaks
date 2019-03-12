
$(function () {
    $("form[id='FormSignIn']").live("submit", function (event) {
        event.preventDefault();
        var form = $(this);
        var formMode = 'page';
        if ($(this).attr('data-form-mode') == 'reveal')
        {
            formMode = 'reveal';
        }

        $.ajax({
            url: '/Ajax/FormSignIn',
            type: "POST",
            data: form.serialize(),

            success: function (data) {
                var status = data;

                if (status.HasWarning) {
                    cmsShowStatus('#cms-' + formMode + '-StatusCode', 'cms-warning', status.StatusText);

                } else if (status.HasError) {
                    cmsShowStatus('#cms-' + formMode + '-StatusCode', 'cms-error', status.StatusText);

                } else {

                    cmsShowStatus('#cms-' + formMode + '-StatusCode', 'cms-success', status.StatusText);

                    var returnUrl = '/';

                    if (document.referrer) {
                        returnUrl = document.referrer;
                    }

                    if (status.StatusText != '') {
                        $('#cms-' + formMode + '-StatusCode').html(status.StatusText);
                    } else {
                        $('#cms-' + formMode + '-StatusCode').html('You have been signed in .');
                    }

                    if (status.StatusCode.indexOf('OK_CONVIOERROR_') == 0) {
                        cmsEntitySignInResetPageElements();
                        //window.location = returnUrl;
                    }
                    else {
                        if (status.TopicValue + '' != '') {
                            var cmsEntitySingleSignOnUrl2 = cmsEntitySingleSignOnUrl + status.TopicValue;
                            if (formMode == 'reveal') {
                                cmsEntitySingleSignOnUrl2 = cmsEntitySingleSignOnUrl2 + '&redirect=' + cmsHttpsProtocol + '://' + cmsHttpsHost + '/extrd-reveal.html' + '#' + returnUrl;

                                if (cmsHttpHost.indexOf('localhost') == 0) {
                                    $('#iframe_SSO').attr('src', '/extrd-reveal.html#' + returnUrl);
                                }
                                else {
                                    $('#iframe_SSO').attr('src', cmsEntitySingleSignOnUrl2);
                                }

                            }
                            else
                            {
                                cmsEntitySingleSignOnUrl2 = cmsEntitySingleSignOnUrl2 + '&redirect=' + cmsHttpsProtocol + '://' + cmsHttpsHost + '/extrd.html' + '#' + returnUrl;
                                if (cmsHttpHost.indexOf('localhost') == 0) {
                                    $('#iframe_SSO').attr('src', '/extrd.html#' + returnUrl);
                                }
                                else {
                                    $('#iframe_SSO').attr('src', cmsEntitySingleSignOnUrl2);
                                }
                            }
                            
                        }
                        else {
                            cmsEntitySignInResetPageElements();
                            //window.location = returnUrl;
                        }
                    }
                    cmsClearFormElements($('form[id="FormSignIn"]'));
                }
            },
            error: function (jqXhr, textStatus, errorThrown) {
                alert("Error '" + jqXhr.status + "' (textStatus: '" + textStatus + "', errorThrown: '" + errorThrown + "')");
            },
            complete: function () {
                $("#ProgressDialog").dialog("close");
            }
        });
    });
});
