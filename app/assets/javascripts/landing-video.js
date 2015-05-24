$(function () {
    $('#modalVideo').on('shown.bs.modal', function (e) {
        var src = $('#videowrapper').attr('data-iframe-src');
        $('#embedVideo').attr('src', src);
    });

    $('#modalVideo').on('hidden.bs.modal', function (e) {
        $('#embedVideo').attr('src', '');
    });
});
