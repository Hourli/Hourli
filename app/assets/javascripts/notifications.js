$(function(){
    var fetch_notifications = function(){
        console.log('polling...');
        var $notification_bell = $('#notification_bell');
        if($notification_bell.data('url')){
            $.get($notification_bell.data('url'), function(response){
                    update_notifications(response);
                }, "json")
                .fail(function(){
                    console.log("Error fetching notifications from server");
                });
            setTimeout(fetch_notifications, $notification_bell.data('poll-interval'));
        }

    };

    var update_notifications = function(response_data){
        var $notification_badge = $('#notification_badge');
        var number_notifications = response_data;
        var current_val = $notification_badge.text();
        if(number_notifications == 0){
            $notification_badge.text('');
        }else if(number_notifications != current_val){
            $($notification_badge).animateCss('swing');
            $notification_badge.text(number_notifications);
        }
    };

    fetch_notifications();
});
