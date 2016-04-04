$(function(){
    $('#change_role_btn').on('click', function(event){
        var new_role = $(this).attr("data-new-role");
        $.get($(this).attr('href'), {"new_role": new_role},  function(response){
                window.location.reload();
            }, "json")
            .fail(function(){
                alert("Error changing role to " + new_role + ", please try again");
            });
        event.preventDefault();
        event.stopPropagation();
        return false;
    });
});
